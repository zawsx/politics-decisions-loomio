namespace :srt do

LOCALES = [ :en, :cs, :ca, :pt_BR, :ja, :el ]

VIDEO_TEMPLATE = {
  t03: '00:00:01,703 --> 00:00:04,304',
  t08: '00:00:06,105 --> 00:00:10,007',
  t04: '00:00:04,304 --> 00:00:06,005'
}

SRT_FILE_NAME = "cf_video"

  task :build => :environment do
    puts "generating srt for #{LOCALES}"
    ordered_times = VIDEO_TEMPLATE.values.sort

    LOCALES.each do |locale|
      rows = []
      ordered_times.each do |time|
        key = "video.#{VIDEO_TEMPLATE.key(time)}"

        row =[]
        row << time
        row << I18n.t(key ,locale: locale)

        rows << row
      end

      File.open("tmp/#{SRT_FILE_NAME}.#{locale}.srt", 'w') do |file|
        rows.each_with_index do |row,i|
          file.puts i+1
          file.puts row[0]
          file.puts row[1]
          file.puts ""
        end
      end

    end

    puts `cat tmp/#{SRT_FILE_NAME}.en.srt`
  end

end