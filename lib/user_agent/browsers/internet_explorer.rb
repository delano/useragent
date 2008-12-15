class UserAgent
  module Browsers
    module InternetExplorer
      def self.extend?(agent)
        agent.application &&
          agent.application.comment &&
          agent.application.comment[0] == "compatible" &&
          agent.application.comment[1].match(/^MSIE/)
      end

      def browser
        "Internet Explorer"
      end
      
      def version=(v)
        application.comment[1] = "MSIE #{v}"
      end
      
      def version
        application.comment[1].sub("MSIE ", "")
      end

      def compatibility
        application.comment[0]
      end

      def compatible?
        compatibility == "compatible"
      end

      def platform
        "Windows"
      end

      def os
        OperatingSystems.normalize_os(application.comment[2])
      end
    end
  end
end
