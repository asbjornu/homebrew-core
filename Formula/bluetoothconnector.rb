class Bluetoothconnector < Formula
  desc "Connect and disconnect Bluetooth devices"
  homepage "https://github.com/lapfelix/BluetoothConnector"
  url "https://github.com/lapfelix/BluetoothConnector/archive/2.0.0.tar.gz"
  sha256 "41474f185fd40602fb197e79df5cd4783ff57b92c1dfe2b8e2c4661af038ed9b"
  license "MIT"
  head "https://github.com/lapfelix/BluetoothConnector.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "38d8b5c89fd8fee4a746eadaceb399d5b7e1148db2cee896381b6e093aef56e3" => :catalina
    sha256 "1a0c1e83b5640a35c48ba982f1b7cf5b1bebdda6fd4957368262c3e001c740e3" => :mojave
  end

  depends_on :xcode => ["11.0", :build]

  def install
    system "swift", "build", "--disable-sandbox", "-c", "release", "--static-swift-stdlib"
    bin.install ".build/release/BluetoothConnector"
  end

  test do
    shell_output("#{bin}/BluetoothConnector", 64)
    output_fail = shell_output("#{bin}/BluetoothConnector --connect 00-00-00-00-00-00", 252)
    assert_equal "Not paired to device\n", output_fail
  end
end
