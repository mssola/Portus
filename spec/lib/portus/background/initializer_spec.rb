# frozen_string_literal: true

require 'rails_helper'

# A class used to mock ::Portus::Application so we can control de portus
# password being returned as a secret.
class ApplicationMock
  def initialize(password)
    @password = password
  end

  def portus_password
    @password
  end
end

describe ::Portus::Background::Initializer do
  let(:initializer) { described_class.new }

  before :each do
    allow_any_instance_of(::Registries::CreateService).to receive(:check!).and_return(true)
  end

  describe '#execute!' do
    it 'does nothing if the portus user does not exist' do
      expect(initializer).not_to receive(:update_portus_user_password!)
      initializer.execute!
    end

    it 'does nothing if DB raises an error somehow' do
      allow(::User).to receive(:exists?).and_raise(StandardError, 'so grumpy, such error')
      initializer.execute!
    end

    it 'executes everything if the portus user exists' do
      expect(initializer).to receive(:update_portus_user_password!)
      create(:user, username: 'portus')
      initializer.execute!
    end
  end

  describe '#update_portus_user_password!' do
    before do
      create(:user, username: 'portus', password: '12341234')
    end

    it 'does nothing if there is no password for the portus user' do
      allow_any_instance_of(::Portus::Application).to(
        receive(:secrets)
          .and_return(::ApplicationMock.new(''))
      )

      initializer.execute!
      expect(User.portus.valid_password?('12341234')).to be_truthy
    end

    it 'updates the password of the portus user if it was given' do
      allow_any_instance_of(::Portus::Application).to(
        receive(:secrets)
          .and_return(::ApplicationMock.new('anotherpassword'))
      )

      initializer.execute!
      expect(User.portus.valid_password?('anotherpassword')).to be_truthy
    end
  end

  describe '#create_registry_maybe!' do
    before do
      create(:user, username: 'portus', password: '12341234')

      ENV['PORTUS_INIT_REGISTRY_HOSTNAME'] = nil
      ENV['PORTUS_INIT_REGISTRY_USE_SSL'] = nil
    end

    it 'does nothing if one of the needed parameters are missing' do
      expect(initializer).not_to receive(:create_registry!)
      initializer.execute!
    end

    it 'does nothing if there is already an existing registry' do
      create(:registry)

      ENV['PORTUS_INIT_REGISTRY_HOSTNAME'] = 'my.hostname:5000'
      ENV['PORTUS_INIT_REGISTRY_USE_SSL'] = 'true'

      expect(initializer).not_to receive(:create_registry!)
      initializer.execute!
    end

    it 'creates the registry with the given parameters' do
      ENV['PORTUS_INIT_REGISTRY_HOSTNAME'] = 'my.hostname:5000'
      ENV['PORTUS_INIT_REGISTRY_USE_SSL'] = 'true'

      initializer.execute!

      reg = Registry.first
      expect(reg.hostname).to eq 'my.hostname:5000'
      expect(reg.use_ssl).to be_truthy
    end
  end
end
