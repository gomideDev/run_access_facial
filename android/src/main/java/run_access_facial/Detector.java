// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

package run_access_facial;

import com.google.mlkit.vision.common.InputImage;

import java.io.IOException;

import io.flutter.plugin.common.MethodChannel;

public interface Detector {
  void handleDetection(final InputImage image, final MethodChannel.Result result);

  void close() throws IOException;
}
