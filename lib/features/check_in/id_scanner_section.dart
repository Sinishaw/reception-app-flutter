import 'dart:convert';
import 'dart:js' as js;
import 'dart:js_util' as js_util;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import '../../core/theme.dart';

class IdScannerSection extends StatefulWidget {
  final String visitorName;
  final ValueChanged<String?> onUrlChanged;

  const IdScannerSection({
    super.key,
    required this.visitorName,
    required this.onUrlChanged,
  });

  @override
  State<IdScannerSection> createState() => _IdScannerSectionState();
}

class _IdScannerSectionState extends State<IdScannerSection> with SingleTickerProviderStateMixin {
  bool _isScannerInitialized = false;
  String _scannerStatus = 'idle'; // 'idle', 'watching', 'uploading', 'success', 'error'
  String? _scannedFileName;
  String? _scannedFileUrl;
  String? _scannerError;

  // Temporarily store scan metadata for retry support
  dynamic _lastFileHandle;
  Uint8List? _scannedFileBytes;

  late final AnimationController _pulseController;
  late final Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _stopFolderWatching();
    super.dispose();
  }

  void _stopFolderWatching() {
    try {
      if (js.context['idScanner'] != null) {
        js.context['idScanner'].callMethod('stopWatching');
      }
    } catch (e) {
      debugPrint("Error stopping watcher: $e");
    }
  }

  Future<void> _initScanner() async {
    if (js.context['idScanner'] == null) {
      setState(() {
        _scannerStatus = 'error';
        _scannerError = 'ID Scanner JavaScript helper not loaded.';
      });
      return;
    }

    setState(() {
      _scannerStatus = 'idle';
      _scannerError = null;
    });

    try {
      final bool hasPermission = await js_util.promiseToFuture(
        js.context['idScanner'].callMethod('requestPermission')
      );

      if (hasPermission) {
        setState(() {
          _isScannerInitialized = true;
          _scannerStatus = 'watching';
          _scannerError = null;
        });

        js.context['idScanner'].callMethod('startWatching', [
          js.allowInterop((String name, js.JsArray<dynamic> jsBytes, dynamic handle) {
            // Run on widget thread
            if (mounted) {
              final bytes = Uint8List.fromList(List<int>.from(jsBytes));
              _onFileDetected(name, bytes, handle);
            }
          })
        ]);
      } else {
        setState(() {
          _scannerStatus = 'error';
          _scannerError = 'Access to local scanner folder was denied.';
        });
      }
    } catch (e) {
      setState(() {
        _scannerStatus = 'error';
        _scannerError = 'Failed to initialize folder access: $e';
      });
    }
  }

  void _onFileDetected(String name, Uint8List bytes, dynamic handle) {
    final nameVal = widget.visitorName.trim();
    if (nameVal.isEmpty) {
      setState(() {
        _scannerStatus = 'error';
        _scannerError = 'Please enter the visitor\'s full name in the form before scanning.';
        _lastFileHandle = handle;
        _scannedFileBytes = bytes;
        _scannedFileName = name;
      });
      return;
    }

    _processAndUpload(name, bytes, handle, nameVal);
  }

  Future<void> _processAndUpload(String originalName, Uint8List bytes, dynamic handle, String visitorName) async {
    setState(() {
      _scannerStatus = 'uploading';
      _scannerError = null;
    });

    try {
      // 1. Determine extension and target renamed name
      final ext = originalName.contains('.')
          ? originalName.substring(originalName.lastIndexOf('.'))
          : '.pdf';
      final timestamp = DateFormat('yyyyMMdd_HHmmss').format(DateTime.now());
      final cleanName = visitorName.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
      final newName = '${cleanName}_$timestamp$ext';

      // 2. Rename file locally using JS interop move()
      final bool renameSuccess = await js_util.promiseToFuture(
        js.context['idScanner'].callMethod('renameFile', [handle, newName])
      );

      if (!renameSuccess) {
        throw Exception('Unable to rename scan file locally in directory.');
      }

      // 3. Upload bytes to Firebase Storage
      final contentType = newName.toLowerCase().endsWith('.pdf') ? 'application/pdf' : 'image/jpeg';
      final storageRef = FirebaseStorage.instance.ref().child('scanned_ids/$newName');
      
      final uploadTask = storageRef.putData(
        bytes,
        SettableMetadata(contentType: contentType),
      );

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      // 4. Delete renamed local file using JS interop removeEntry()
      await js_util.promiseToFuture(
        js.context['idScanner'].callMethod('deleteFile', [newName])
      );

      setState(() {
        _scannerStatus = 'success';
        _scannedFileName = newName;
        _scannedFileUrl = downloadUrl;
        _lastFileHandle = null;
        _scannedFileBytes = null;
      });

      widget.onUrlChanged(downloadUrl);

    } catch (e) {
      setState(() {
        _scannerStatus = 'error';
        _scannerError = '$e';
        _lastFileHandle = handle;
        _scannedFileBytes = bytes;
        _scannedFileName = originalName;
      });
    }
  }

  void _retryUpload() {
    final nameVal = widget.visitorName.trim();
    if (nameVal.isEmpty) {
      setState(() {
        _scannerStatus = 'error';
        _scannerError = 'Please enter the visitor\'s full name before retrying.';
      });
      return;
    }

    if (_scannedFileBytes != null && _lastFileHandle != null && _scannedFileName != null) {
      _processAndUpload(_scannedFileName!, _scannedFileBytes!, _lastFileHandle!, nameVal);
    } else {
      // Fallback: reset state to watching
      setState(() {
        _scannerStatus = 'watching';
        _scannerError = null;
      });
    }
  }

  void _clearScan() {
    setState(() {
      _scannedFileName = null;
      _scannedFileUrl = null;
      _scannerStatus = 'watching';
      _scannerError = null;
      _lastFileHandle = null;
      _scannedFileBytes = null;
    });
    widget.onUrlChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: AppColors.secondary.withOpacity(0.08)),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID Document Scanner',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
                if (_isScannerInitialized) _buildStatusBadge(),
              ],
            ),
            const SizedBox(height: 20),
            if (!_isScannerInitialized)
              _buildInitializationPrompt()
            else
              _buildScannerPanel(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge() {
    Color color = Colors.grey;
    String label = 'Inactive';
    bool pulse = false;

    switch (_scannerStatus) {
      case 'watching':
        color = Colors.green;
        label = 'Watching Folder';
        pulse = true;
        break;
      case 'uploading':
        color = Colors.blue;
        label = 'Uploading...';
        pulse = true;
        break;
      case 'success':
        color = Colors.green;
        label = 'Upload Complete';
        break;
      case 'error':
        color = Colors.red;
        label = 'Scan Error';
        break;
    }

    final dot = Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          pulse
              ? AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) => Opacity(opacity: _pulseAnimation.value, child: dot),
                )
              : dot,
          const SizedBox(width: 6),
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontSize: 9,
              color: color,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInitializationPrompt() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Icon(Icons.folder_shared_outlined, size: 40, color: AppColors.secondary),
          const SizedBox(height: 12),
          const Text(
            'Local Folder Permission Required',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
          ),
          const SizedBox(height: 4),
          const Text(
            'Select the scanner folder (e.g. C:\\Visitors\\ScannedIDs) to begin automatically detecting scans.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _initScanner,
            icon: const Icon(Icons.folder_open, size: 18),
            label: const Text('Select Watch Folder'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerPanel() {
    switch (_scannerStatus) {
      case 'watching':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 36),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.02),
            border: Border.all(color: Colors.green.withOpacity(0.12)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
                width: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Waiting for network scanner...',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Insert ID into scanner and press physical button.',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.secondary.withOpacity(0.6),
                ),
              ),
            ],
          ),
        );

      case 'uploading':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              const Icon(Icons.cloud_upload_outlined, size: 36, color: AppColors.primary),
              const SizedBox(height: 16),
              const Text(
                'Scan detected! Uploading to Storage...',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.secondary),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: LinearProgressIndicator(minHeight: 3, valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)),
              ),
            ],
          ),
        );

      case 'success':
        return _buildPreviewCard();

      case 'error':
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red.withOpacity(0.04),
            border: Border.all(color: Colors.red.withOpacity(0.1)),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.error_outline_rounded, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    'Error during scan processing',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _scannerError ?? 'Unknown error occurred.',
                style: TextStyle(fontSize: 12, color: Colors.black87),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => setState(() => _scannerStatus = 'watching'),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: _retryUpload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text('Retry Upload'),
                  ),
                ],
              )
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildPreviewCard() {
    if (_scannedFileUrl == null) return const SizedBox.shrink();

    final isPdf = _scannedFileName?.toLowerCase().endsWith('.pdf') ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Scanned Document File',
                    style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _scannedFileName ?? 'scanned_id.pdf',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
              tooltip: 'Clear Scan',
              onPressed: _clearScan,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            color: AppColors.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.secondary.withOpacity(0.05)),
          ),
          clipBehavior: Clip.antiAlias,
          child: isPdf ? _buildPdfPlaceholder() : _buildImagePreview(),
        ),
      ],
    );
  }

  Widget _buildImagePreview() {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.network(
            _scannedFileUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return const Center(child: CircularProgressIndicator());
            },
            errorBuilder: (context, error, stackTrace) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.broken_image_outlined, color: Colors.grey, size: 36),
                    SizedBox(height: 8),
                    Text('Failed to load image preview', style: TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 12,
          right: 12,
          child: FloatingActionButton.small(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            tooltip: 'Open in new tab',
            onPressed: () => js.context.callMethod('open', [_scannedFileUrl, '_blank']),
            child: const Icon(Icons.open_in_new, size: 16),
          ),
        )
      ],
    );
  }

  Widget _buildPdfPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 48),
          const SizedBox(height: 12),
          const Text(
            'PDF Document Uploaded',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () => js.context.callMethod('open', [_scannedFileUrl, '_blank']),
            icon: const Icon(Icons.open_in_new, size: 16),
            label: const Text('View Document', style: TextStyle(fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          )
        ],
      ),
    );
  }
}
