class Sonarqube < Formula
  desc "Manage code quality"
  homepage "https://www.sonarqube.org/"
  url "https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-8.4.2.36762.zip"
  sha256 "99a3d7b24a65d8c48d01b0c4965914191c8a7b75e40f9c23cce60c48673bdc1c"
  license "LGPL-3.0-or-later"

  livecheck do
    url "https://binaries.sonarsource.com/Distribution/sonarqube/"
    regex(/href=.*?sonarqube[._-]v?(\d+(?:\.\d+)+)\.zip/i)
  end

  bottle :unneeded

  depends_on "openjdk"

  conflicts_with "sonarqube-lts", because: "both install the same binaries"

  def install
    # Delete native bin directories for other systems
    rm_rf "bin/linux-x86-32"
    rm_rf "bin/linux-x86-64" if OS.mac?
    rm_rf "bin/macosx-universal-32"
    rm_rf "bin/macosx-universal-64" unless OS.mac?
    rm_rf Dir["bin/windows-*"]

    libexec.install Dir["*"]

    (bin/"sonar").write_env_script libexec/"bin/#{OS.mac? ? "macosx-universal-64" : "linux-x86-64"}/sonar.sh",
      JAVA_HOME: Formula["openjdk"].opt_prefix
  end

  plist_options manual: "sonar console"

  def plist
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
          <string>#{opt_bin}/sonar</string>
          <string>start</string>
          </array>
          <key>RunAtLoad</key>
          <true/>
      </dict>
      </plist>
    EOS
  end

  test do
    assert_match "SonarQube", shell_output("#{bin}/sonar status", 1)
  end
end
