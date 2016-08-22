
class PlantumlService < Formula
  desc "PlantUML HTTP service"
  homepage "https://github.com/gfx/plantuml-service"

  url "https://github.com/gfx/plantuml-service/archive/v1.0.0.tar.gz"
  sha256 "bac44f70194018d75abca7deb03654899c73435cb7c7e7a3e9fb362b390b1657"

  depend_on :java
  depend_on "graphviz"

  def install
    system("./gradlew --no-daemon --info --stacktrace stage")

    libexec.install "bin"
    bin.write_exec_script Dir[libexec/"bin/plantuml-service"]
  end

  def plist;
    port = 1608
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
            <string>#{HOMEBREW_PREFIX}/bin/plantuml-service</string>
            <string>#{port}</string>
          </array>
          <key>EnvironmentVariables</key>
          <dict>
          </dict>
          <key>RunAtLoad</key>
          <true/>
          <key>WorkingDirectory</key>
          <string>#{var}</string>
          <key>StandardErrorPath</key>
          <string>#{var}/log/stderr.log</string>
          <key>StandardOutPath</key>
          <string>#{var}/log/stdout.log</string>
        </dict>
      </plist>
    EOS
  end
end
