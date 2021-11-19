class CreditDetail < ApplicationRecord
    META_FIELDS = %i[credit_limit_val credibility_score_val].freeze
    after_create :credit_limit, :credibility_score, :credit_detail_update

    require 'json'
    @@data_hash = JSON.parse('{
        "email" : "cdsdc@c",
        "status" : 200,"requestId" : "e158b690-4c96-4542-bd1a-f5a374580156",
        "likelihood" : 0.95,
        "contactInfo" : {
        "familyName" : "Raphy",
        "fullName" : "Renil Raphy",
        "givenName" : "Renil"
        },
        "organizations" : [ {
        "isPrimary" : false,
        "name" : "Skreem",
        "startDate" : "2016-03",
        "title" : "Software Developer",
        "current" : true
        }, {
        "isPrimary" : false,
        "name" : "Carettech Cosultancy Ltd",
        "startDate" : "2013-10",
        "title" : "Junior Software Engineer",
        "current" : true
        } ],
        "demographics" : {
        "locationDeduced" : {
        "deducedLocation" : "Thrissur, Kerala, India",
        "city" : {
        "deduced" : false,
        "name" : "Thrissur"
        },
        "state" : {
        "deduced" : false,
        "name" : "Kerala"
        },
        "country" : {
        "deduced" : false,
        "name" : "India",
        "code" : "IN"
        },
        "continent" : {
        "deduced" : true,
        "name" : "Asia"
        },
        "county" : {
        "deduced" : true,
        "name" : "Thrissur District"
        },"likelihood" : 1.0
        },
        "gender" : "Male",
        "locationGeneral" : "Thrissur, Kerala, India"
        },
        "socialProfiles" : [ {
        "bio" : "I am working on Web applications mainly in Ruby on Rails, and have knowledge in Django framework too.",
        "followers" : 272,
        "following" : 272,
        "type" : "linkedin",
        "typeId" : "linkedin",
        "typeName" : "LinkedIn",
        "url" : "https://www.linkedin.com/in/renil-raphy-16a35661",
        "username" : "renil-raphy-16a35661",
        "id" : "218837602"
        }, {
        "followers" : 28,
        "following" : 34,
        "type" : "twitter",
        "typeId" : "twitter",
        "typeName" : "Twitter",
        "url" : "https://twitter.com/renilraphyp100",
        "username" : "renilraphyp100",
        "id" : "1269251400"
    } ] }
    ')
    def credit_limit
        term_in_month = 0
        max_possible_emi = (balance_inflow/2 - balance_outflow)
        if max_possible_emi >=0 and max_possible_emi <=5000
            term_in_month = 6
        elsif max_possible_emi > 5000 and max_possible_emi <= 10000
            term_in_month = 12
        elsif max_possible_emi > 10000 and max_possible_emi <= 20000
            term_in_month = 12
        else
            term_in_month = 24
        end
        credit_limit_value = max_possible_emi * term_in_month 
    end

    META_FIELDS.each do |key| 
        define_method("#{key}?") do
          meta[key.to_s].present? || meta[key].present?
        end
        define_method(key.to_s) do
          meta[key.to_s] || meta[key]
        end
        define_method("#{key}=") do |value = nil|
          meta[key] = value
        end
      end

    def credit_detail_update 
        credit_detail = CreditDetail.find(id)
        credit_detail.credit_limit_val = credit_limit
        if credibility_score >= 2
            credit_detail.credibility_score_val = "APPROVED"
        else
            credit_detail.credibility_score_val = "REJECTED"
        end
        credit_detail.save
    end

    def credibility_score
        data = @@data_hash
        count = 0
        if email == data["email"]
            profile = data["socialProfiles"]
            len = profile.length
            for hash in profile do
                if hash["type"]= "linkedin"
                    count = count+1
                elsif hash["type"] = "twitter"
                    count = count + 1
                elsif hash["type"] = "facebook"
                    count = count +1
                end
            end
        end
      return count

    end
    
end

