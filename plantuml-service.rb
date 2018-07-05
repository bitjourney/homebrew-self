# frozen_string_literal: true

class PlantumlService < Formula
  desc "PlantUML HTTP service"
  homepage "https://github.com/gfx/plantuml-service"

  url "https://github.com/bitjourney/plantuml-service/archive/v1.3.2.tar.gz"
  sha256 "9535304c7fc514c2da03104c104dd754cc7a8fd4f200a4014827e403a6d71337"

  depends_on :java
  depends_on "graphviz"

  def install
    system("./gradlew --no-daemon --info --stacktrace stage")

    libexec.install "bin"
    bin.write_exec_script Dir[libexec/"bin/plantuml-service"]
  end

  def plist;
    port = 1608
    graphvizDot = `which dot`.strip
    <<~EOS
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
        <dict>
          <key>KeepAlive</key>
          <false/>
          <key>Label</key>
          <string>#{plist_name}</string>
          <key>ProgramArguments</key>
          <array>
            <string>#{bin}/plantuml-service</string>
            <string>#{port}</string>
            <string>#{graphvizDot}</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
          </dict>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/plantuml-service.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/plantuml-service.log</string>
        </dict>
      </plist>
    EOS
  end
end
