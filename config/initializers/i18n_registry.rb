module I18n
  module Registry
    protected
    def lookup(locale, key, scope = [], options = {})
      @log ||= Logger.new(File.join(Rails.root, 'log', 'i18n_registry.log'))
      @log.info "#{key} - #{scope} - #{options}"
      super
    end
  end
end

I18n::Backend::Simple.send :include, I18n::Registry
