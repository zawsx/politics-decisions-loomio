namespace :srt do

LOCALES = [:en, :pt_BR, :el, :es, :ca, :cs, :fr, :ja, :nl_NL, :vi]

VIDEO_TEMPLATE = {
  t06: '00:00:03,900 --> 00:00:08,509',
  t07: '00:00:08,509 --> 00:00:12,500',
  t08: '00:00:12,500 --> 00:00:15,700',
  t09: '00:00:16,300 --> 00:00:25,000',
  t10: '00:00:25,000 --> 00:00:30,400',
  t11: '00:00:30,500 --> 00:00:35,200',
  t12: '00:00:35,200 --> 00:00:40,300',
  t13: '00:00:40,300 --> 00:00:46,000',
  t14: '00:00:46,100 --> 00:00:48,900',
  t15: '00:00:48,900 --> 00:00:59,400',
  t16: '00:01:00,000 --> 00:01:02,900',
  t17: '00:01:02,900 --> 00:01:05,500',
  t18: '00:01:06,500 --> 00:01:08,300',
  t19: '00:01:08,400 --> 00:01:12,800',
  t20: '00:01:12,800 --> 00:01:15,059',
  t21: '00:01:15,600 --> 00:01:18,000',
  t22: '00:01:18,000 --> 00:01:20,600',
  t23: '00:01:20,600 --> 00:01:24,500',
  t24: '00:01:24,600 --> 00:01:32,900',
  t26: '00:01:33,300 --> 00:01:39,600',
  t28: '00:01:39,600 --> 00:01:44,200',
  t31: '00:01:44,200 --> 00:01:49,540',
  t32: '00:01:49,540 --> 00:01:52,500',
  t33: '00:01:52,800 --> 00:01:56,740',
  t34: '00:01:56,740 --> 00:02:05,100',
  t35: '00:02:05,200 --> 00:02:08,400',
  t36a: '00:02:08,600 --> 00:02:19,819',
  t36b: '00:02:19,819 --> 00:02:26,600',
  t37: '00:02:26,610 --> 00:02:29,400',
  t38: '00:02:29,470 --> 00:02:35,000',
  t39: '00:02:35,200 --> 00:02:42,400',
  t40: '00:02:42,400 --> 00:02:44,200',
  t41: '00:02:44,300 --> 00:02:49,500',
  t42: '00:02:49,600 --> 00:02:54,000'
}

SRT_FILE_NAME = "loomio_cf"

  task :build => :environment do
    puts "generating srt for #{LOCALES}"
    ordered_times = VIDEO_TEMPLATE.values.sort

    LOCALES.each do |locale|
      rows = []
      ordered_times.each do |time|
        key = "video.#{VIDEO_TEMPLATE.key(time)}"

        unless locale.to_s == 'en'
          if I18n.t(key ,locale: locale) == I18n.t(key ,locale: 'en')
            puts "[#{locale}] Missing #{key}: #{I18n.t(key ,locale: 'en')}"
          end
        end

        row =[]
        row << time
        row << I18n.t(key ,locale: locale)

        rows << row
      end

      File.open("config/locales/cf_subtitles/#{SRT_FILE_NAME}.#{locale}.srt", 'w') do |file|
        rows.each_with_index do |row,i|
          file.puts i+1
          file.puts row[0]
          file.puts row[1]
          file.puts ""
        end
      end

    end

    # puts `cat tmp/#{SRT_FILE_NAME}.en.srt`
  end

end