# zeus rake languages:update

namespace :languages do
  task :update => :environment do
    @options = { basic_auth: {username: ENV['TRANSIFEX_USERNAME'], password: ENV['TRANSIFEX_PASSWORD']} }

    language_info = HTTParty.get('http://www.transifex.com/api/2/project/loomio-1/languages', @options)
    languages = language_info.each.map do |l|
       l['language_code']
    end

    def update(language)
      response = HTTParty.get("http://www.transifex.com/api/2/project/loomio-1/resource/github-linked-version/translation/#{language}", @options)

      if response.present?
        content = response['content']

        simplified_language = language.split('_')[0]
        content = content.gsub(language, simplified_language)

        target = File.open("config/locales/#{simplified_language}.yml", 'w')
        target.write(content)
        target.close()

        puts "#{simplified_language} processed"
      end
    end

    languages.each do |language|
      update(language)
    end

    puts "Remember to check EXPERIMENTAL_LANGUAGES array ^_^"
  end

  task :check => :environment do
    def flat_hash(hash, k = "")
      return {k => hash} unless hash.is_a?(Hash)
      hash.inject({}){ |h, v| h.merge! flat_hash(v[-1], k + '/' + v[0]) }
    end

    en = YAML.load_file("config/locales/en.yml")
    es = YAML.load_file("config/locales/es.yml")


    "/a/1/A/Standard".split('/')[2..-1].join(':')


    # def flat_hash(h, k = [])
    #   new_hash = {}
    #   h.each_pair do |key, val|
    #     if val.is_a?(Hash)
    #       new_hash.merge!(flat_hash(val, k + [key]))
    #     else
    #       new_hash[k + [key]] = val
    #     end
    #   end
    #   new_hash
    # end

    # def flat_hash(hash, k = [])
    #   return {k => hash} unless hash.is_a?(Hash)
    #   hash.inject({}){ |h, v| h.merge! flat_hash(v[-1], k + [v[0]]) }
    # end



  end
end