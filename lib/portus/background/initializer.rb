# frozen_string_literal: true

module Portus
  module Background
    # Initializer implements all the initialization code that might be needed by
    # Portus that falls out of the typical code in `config/initializers`. That
    # is, checking that some data on the DB is properly initialized. Right now
    # it takes care of two tasks:
    #
    #   - Updating the password of the Portus user.
    #   - Creating a registry object automatically into the database based on
    #     the `PORTUS_INIT_REGISTRY_NAME`, `PORTUS_INIT_REGISTRY_HOSTNAME` and
    #     `PORTUS_INIT_REGISTRY_USE_SSL` environment variables.
    class Initializer
      # Performs the initialization routines that might be needed.
      def execute!
        return unless portus_user_available?

        update_portus_user_password!
        create_registry_maybe!
      end

      protected

      # Returns true of the Portus user exists, false otherwise.
      def portus_user_available?
        User.exists?(username: "portus")
      rescue StandardError
        # We will ignore any error and skip the initializer. This is done this
        # way because it can get really tricky to catch all the myriad of
        # exceptions that might be raised on database errors.
        false
      end

      # Make sure that the Portus user has the proper password.
      def update_portus_user_password!
        password = Rails.application.secrets.portus_password
        return if password.blank?

        portus = User.portus
        portus&.update_attribute("password", password)
      end

      # Create the registry as given by the proper environment variables if needed.
      def create_registry_maybe!
        return unless ::Registry.count.zero?

        params = {
          name:     ENV["PORTUS_INIT_REGISTRY_NAME"] || "registry",
          hostname: ENV["PORTUS_INIT_REGISTRY_HOSTNAME"],
          use_ssl:  ENV["PORTUS_INIT_REGISTRY_USE_SSL"]
        }
        return if params[:hostname].blank? || params[:use_ssl].blank?

        create_registry!(params)
      end

      # Creates a new registry with the given parameters. This method assumes that the
      # database is ready and that there is no registry setup already.
      def create_registry!(params)
        svc = ::Registries::CreateService.new(nil, params)
        svc.execute
        return unless svc.valid?

        Rails.logger.tagged("registry") do
          msg = JSON.pretty_generate(params)
          Rails.logger.info "Registry created with the following parameters:\n#{msg}"
        end
      end
    end
  end
end
