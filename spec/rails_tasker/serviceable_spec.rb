# frozen_string_literal: true

require 'spec_helper'
require 'rails_tasker/serviceable'

RSpec.describe RailsTasker::Serviceable do
  let(:klass) do
    Class.new do
      include RailsTasker::Serviceable
    end
  end
  let(:instance) { klass.new }

  describe '.included' do
    before { allow(klass).to receive(:extend) }

    it 'extends the class with ClassMethods' do
      RailsTasker::Serviceable.included klass
      expect(klass).to have_received(:extend).with(
        RailsTasker::Serviceable::ClassMethods
      ).once
    end
  end

  describe '#call' do
    it 'raises NotImplementedError' do
      expect { instance.call }.to raise_error NotImplementedError
    end
  end

  describe 'ClassMethods' do
    describe '.call' do
      let(:klass) do
        Class.new do
          include RailsTasker::Serviceable

          def call; end
        end
      end

      before do
        allow(klass).to receive(:new).and_return instance
        allow(instance).to receive(:call).and_call_original
      end
  
      it 'creates new instance' do
        klass.call
        expect(klass).to have_received(:new).with(no_args).once
      end

      it 'calls the #call method on the instance' do
        klass.call
        expect(instance).to have_received(:call).with(no_args).once
      end

      context 'with args' do
        let(:klass) do
          Class.new do
            include RailsTasker::Serviceable
  
            def call(test:, fake: nil); end
          end
        end

        it 'passes args to the #call method on the instance' do
          klass.call(test: true)
          expect(instance).to have_received(:call).with(test: true).once
        end
      end
    end
  end
end
