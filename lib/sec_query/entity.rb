module SecQuery
    class Entity

        attr_accessor :first, :middle, :last, :name, :symbol, :cik, :url, :type, :sic, :location, :state_of_inc, :formerly, :mailing_address, :business_address, :relationships, :transactions, :filings
        
        # def initialize(entity)
        #     @first = entity[:first]
        #     @middle = entity[:middle]
        #     @last = entity[:last]
        #     @name = entity[:name]
        #     @sic = entity[:sic]
        #     @url = entity[:url]
        #     @location = entity[:location]
        #     @state_of_inc = entity[:state_of_inc]
        #     @formerly = entity[:formerly]
        #     @symbol = entity[:symbol]
        #     @cik = entity[:cik]
        #     @type =entity[:type]
        #     @mailing_address = entity[:mailing_address]
        #     @business_address = entity[:business_address]
        #     @relationships = entity[:relationships]
        #     @transactions = entity[:transactions]
        #     @filings = entity[:filings]
        # end
   

        def self.find(entity_args, *options)
            Entity.cik(Entity.url(entity_args), entity_args)
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

        def self.cik(url, entity)
            response = Entity.query(url+"&output=atom")
            # puts response
            entries = []
            Nokogiri::HTML(response).xpath('//feed/entry').each do |e|
                # e.remove_namespaces!('link')
                if e.xpath('//content/company-info').to_s.length > 0
                    doc = Hashie::Mash.new(Crack::XML.parse(e.xpath('//content/company-info').to_s))
                end
                if e.xpath('//company-info').to_s.length > 0
                    doc = Hashie::Mash.new(Crack::XML.parse(e.xpath('//company-info').to_s))
                end
                if e.xpath('//content/accession-nunber').to_s.length > 0
                    doc = Crack::XML.parse(e.xpath('//content').to_s).collect {|k, v| v }
                end
                
                entries << doc
            end

            return entries
        end

   end
end
