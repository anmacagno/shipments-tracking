namespace :shipments do
  desc 'Synchronize shipments for a given carrier'
  task :synchronize, [:carrier] => :environment do |task, args|
    result = SynchronizeShipments.call(carrier: args.carrier)
    if result.success?
      count = "#{result.published.size} of #{result.shipments.size}"
      puts "Shipments synchronized successfully: #{count}"
    else
      puts result.error
    end
  end
end
