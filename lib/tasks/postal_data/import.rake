require 'csv'

namespace :postal_data do
  desc "Import Turkish postal codes from CSV"
  task import: :environment do
    file_path = Rails.root.join('lib', 'assets', 'postal_codes_turkey.csv')
    
    unless File.exist?(file_path)
      puts "Error: File not found at #{file_path}"
      puts "Please create the CSV file with this structure:"
      puts "province_name,district_name,neighborhood_name,postal_code"
      next
    end

    import_count = 0
    start_time = Time.now

    # Disable logging for performance
    old_logger = ActiveRecord::Base.logger
    ActiveRecord::Base.logger = nil

    begin
      CSV.foreach(file_path, headers: true) do |row|
        province = Province.find_or_create_by!(
          name: row['province_name'].to_s.strip,
          slug: row['province_name'].to_s.parameterize
        )

        district = District.find_or_create_by!(
          name: row['district_name'].to_s.strip,
          province: province
        )

        neighborhood = Neighborhood.create_with(province: province).find_or_create_by!(
          name: row['neighborhood_name'].to_s.strip,
          district: district
        )

        PostalCode.find_or_create_by!(
          code: row['postal_code'].to_s.strip,
          neighborhood: neighborhood
        )

        import_count += 1
        print '.' if import_count % 100 == 0 # Progress indicator
      end

      puts "\n✅ Completed in #{Time.now - start_time} seconds"
      puts "Total records imported: #{import_count}"
    ensure
      # Restore logging
      ActiveRecord::Base.logger = old_logger
    end
  end
end