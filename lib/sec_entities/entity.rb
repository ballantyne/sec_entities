module Sec
  class Entity
    attr_accessor :first, :middle, :last, :name, :symbol, :cik, :url, :type, :sic, :location, :state_of_inc, 
                  :formerly, :mailing_address, :business_address, :relationships, :transactions, :filings

    def self.find(entity_args, *options)
      Entity.lookup(Entity.url(entity_args), entity_args)
    end


    def self.query(url)
      RestClient.get(url){ |response, request, result, &block|
        case response.code
          when 200
          return response
          else
          response.return!(request, result, &block)
        end
      }
    end


    def self.url(args)
      if args.is_a?(Hash)
        if args[:symbol] != nil
          string = "CIK="+args[:symbol]
        elsif args[:cik] != nil
          string = "CIK="+args[:cik]
        elsif args[:first] != nil and args[:last]
          string = "company="+args[:last]+" "+args[:first]
        elsif args[:name] != nil
          string = "company="+args[:name].gsub(/[(,?!\''"":.)]/, '')
        end
      elsif args.is_a?(String)
        begin Float(args)
            string = "CIK="+args
        rescue
          if args.length <= 4
            string = "CIK="+args
          else
            string = "company="+args.gsub(/[(,?!\''"":.)]/, '')
          end
        end
      end
      string = string.to_s.gsub(" ", "+")
      url = "http://www.sec.gov/cgi-bin/browse-edgar?"+string+"&action=getcompany"
      return url
    end

    def self.lookup(url, entity)
      response = Entity.query(url+"&output=atom")
      # puts response.to_s
      entries = []
      doc = Hashie::Mash.new
      content = []
      document = Nokogiri::HTML(response)
      company_info = Crack::XML.parse(document.xpath('//feed/company-info').to_s)['company_info']   if document.xpath('//feed/company-info').to_s.length > 0
      company_info = Crack::XML.parse(document.xpath('//content/company-info').to_s)['company_info'] if document.xpath('//feed/entry/content/company-info').to_s.length > 0
      doc.company_info = company_info
      if document.xpath('//feed/entry').to_s.length > 0
        document.xpath('//feed/entry/content').each do |e|
          content << Crack::XML.parse(e.to_s)['content'] if e.xpath('//content/accession-nunber').to_s.length > 0
        end
      end
      
      doc.filings = content  if content.size > 0

      return doc
    end
  end
end
