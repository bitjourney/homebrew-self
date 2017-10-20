class PlantumlService < Formula
  desc "PlantUML HTTP service"
  homepage "https://github.com/gfx/plantuml-service"

  url "https://github.com/bitjourney/plantuml-service/archive/v1.2.0.tar.gz"
  sha256 "d63ee39a0d9d069572ba3b8df5220190b7a4f658e3b92fab1bbab896c0906781"

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
    <<-EOS.undent
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
