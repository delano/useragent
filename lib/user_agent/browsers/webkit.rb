class UserAgent
  module Browsers
    module Webkit
      def self.extend?(agent)
        agent.detect { |useragent| useragent.product == "Safari" }
      end

      def browser
        if detect_product("Chrome")
          "Chrome"
        else
          "Safari"
        end
      end

      def build
        safari.version
      end
      
      # TODO: Complete this mapping
      # See: http://www.useragentstring.com/pages/Safari/
      BuildVersions = {
        "125.12" => "1.2.4",
        "312.6" => "1.3.2",
        "412.2.2" => "2.0",
        "412.5" => "2.0.1",
        "416.13" => "2.0.2",
        "417.9.3" => "2.0.3",
        "525.13" => "2.2",
        "522.11.3" => "3.0",
        "523.15" => "3.0",
        "523.12.9" => "3.0",
        "522.12.2" => "3.0.1",
        "522.13.1" => "3.0.2",
        "522.15.5" => "3.0.3",
        "523.10" => "3.0.4",
        "523.15" => "3.0.4",
        "523.12" => "3.0.4",
        "523.12.2" => "3.0.4",
        "525.13" => "3.1",
        "525.13.3" => "3.1",
        "525.9" => "3.1",
        "525.17" => "3.1.1",
        "525.9" => "3.1.1",
        "525.20" => "3.1.1",
        "525.18" => "3.1.1",
        "525.21" => "3.1.2",
        "525.26.13" => "3.2",
        "525.26.12" => "3.2",
        "528.1" => "4.0"
        
      }.freeze unless defined? BuildVersions

      # Prior to Safari 3, the user agent did not include a version number
      def version
        if browser == "Chrome"
          chrome.version
        elsif product = detect_product("Version")
          product.version
        else
          BuildVersions[build]
        end
      end
      
      def version=(v)
        if browser == "Chrome"
          chrome.version = v
        elsif product = detect_product("Version")
          product.version = v
        end
      end
      
      def platform
        application.comment[0]
      end

      def webkit
        detect { |useragent| useragent.product == "AppleWebKit" }
      end

      def security
        Security[application.comment[1]]
      end

      def os
        OperatingSystems.normalize_os(application.comment[2])
      end

      def localization
        application.comment[3]
      end
    end
  end
end
