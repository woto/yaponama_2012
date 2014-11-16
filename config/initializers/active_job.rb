Rails.application.config.active_job.queue_adapter = Rails.application.config_for('application/active_job')['queue_adapter']
