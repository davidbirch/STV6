module ApplicationHelper
  
  def title(title = nil)
    #log = Logger.new(File.expand_path("#{Rails.root}/log/application_helper.log", __FILE__))
    #log.info("#{site_variables.inspect}")
    
    if title.present?
      title
    elsif @title.present?
      @title
    else
      site_variables["default_title"]
    end
  end
    
  def website_plain_english_formatted_name(website_plain_english_formatted_name = nil)
    if website_plain_english_formatted_name.present?
      website_plain_english_formatted_name
    elsif @website_plain_english_formatted_name.present?
      @website_plain_english_formatted_name
    else
      site_variables["website_plain_english_formatted_name"]
    end
  end
  
  def website_plain_english_formatted_l2_name(website_plain_english_formatted_l2_name = nil)
    if website_plain_english_formatted_l2_name.present?
      website_plain_english_formatted_l2_name
    elsif @website_plain_english_formatted_l2_name.present?
      @website_plain_english_formatted_l2_name
    else
      site_variables["website_plain_english_formatted_l2_name"]
    end
  end
  
  def website_url_formatted_name(website_url_formatted_name = nil)
    if website_url_formatted_name.present?
      website_url_formatted_name
    elsif @website_url_formatted_name.present?
      @website_url_formatted_name
    else
      site_variables["website_url_formatted_name"]
    end
  end
  
  def website_contact_email(website_contact_email = nil)
    if website_contact_email.present?
      website_contact_email
    elsif @website_contact_email.present?
      @website_contact_email
    else
      site_variables["website_contact_email"]
    end
  end
    
    private
    
      def site_variables
        site_variables_yaml = YAML.load_file(File.expand_path("#{Rails.root}/config/site_variables.yml", __FILE__))
        site_variables_yaml[Rails.env]
      end
  
end
