namespace :shipments do
  desc 'Synchronize shipments for a given carrier'
  task :synchronize, [:carrier] => :environment do |task, args|
    Rails.logger = Logger.new(STDOUT)
    Rails.logger.level = Logger::INFO
    result = SynchronizeShipments.call(carrier: args.carrier)
    if result.success?
      count = "#{result.published.size} of #{result.shipments.size}"
      Rails.logger.info("Shipments synchronized successfully: #{count}")
    else
      Rails.logger.info(result.error)
    end
  end
end
