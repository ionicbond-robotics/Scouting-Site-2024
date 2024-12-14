import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'dart:convert';

import 'package:universal_html/html.dart' as html;

class CameraCaptureWidget extends StatefulWidget {
  final bool multiple;
  final Function(List<Uint8List>)? onImageListUpdated;

  const CameraCaptureWidget({
    super.key,
    this.multiple = false,
    this.onImageListUpdated,
  });

  @override
  State<CameraCaptureWidget> createState() => _CameraCaptureWidgetState();
}

class _CameraCaptureWidgetState extends State<CameraCaptureWidget> {
  List<Uint8List> _images = [];
  html.VideoElement? _videoElement;

  @override
  void initState() {
    super.initState();
    _initializeWebCamera();
  }

  // Initialize the web camera
  Future<void> _initializeWebCamera() async {
    try {
      final html.VideoElement videoElement = html.VideoElement()
        ..width = 640
        ..height = 480
        ..style.border = '1px solid black';

      final html.MediaStream? stream = await html.window.navigator.mediaDevices
          ?.getUserMedia({'video': true});
      videoElement.srcObject = stream;
      html.document.body!
          .append(videoElement); // Append to DOM to display video
      videoElement.play();

      setState(() {
        _videoElement = videoElement;
      });
    } catch (e) {
      log("Error accessing web camera: $e");
    }
  }

  // Capture an image from the video element
  Future<void> _captureImage() async {
    if (_videoElement == null) {
      log("Web camera is not initialized.");
      return;
    }

    try {
      final html.CanvasElement canvas =
          html.CanvasElement(width: 640, height: 480);
      final html.CanvasRenderingContext2D context = canvas.context2D;
      context.drawImage(_videoElement!, 0, 0);

      // Capture the image from canvas and convert it to a Uint8List
      final imageBytes = canvas.toDataUrl('image/png');
      final decodedBytes = base64Decode(imageBytes.split(',').last);

      setState(() {
        if (widget.multiple) {
          _images.add(Uint8List.fromList(decodedBytes));
        } else {
          _images = [Uint8List.fromList(decodedBytes)];
        }
      });

      widget.onImageListUpdated?.call(_images);
    } catch (e) {
      log("Error capturing image: $e");
    }
  }

  @override
  void dispose() {
    _videoElement?.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _videoElement != null
            ? const AspectRatio(
                aspectRatio: 640 / 480,
                child: HtmlElementView(viewType: 'videoElement'),
              )
            : const Text('Loading camera...'),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: _captureImage,
          child: Text(widget.multiple ? 'Capture Images' : 'Capture Image'),
        ),
        const SizedBox(height: 20),
        _images.isNotEmpty
            ? Wrap(
                children: _images
                    .map((imageBytes) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.memory(
                            imageBytes,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ))
                    .toList(),
              )
            : const Text('No images captured yet.'),
      ],
    );
  }
}
