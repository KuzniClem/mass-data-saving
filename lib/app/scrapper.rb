# frozen_string_literal: true

class Scrapper
  attr_accessor :data_to_save

  def initialize
    page_url = 'http://www.annuaire-des-mairies.com/val-d-oise.html'
    page = Nokogiri::HTML(open(page_url.to_s))
    url_a = page.xpath('/html/body
      /table//tr[3]//tr[1]//td[2]//table[1]//tr[2]//tr//a/@href').map(&:to_s)
    names_a = page.xpath('/html/body
      /table//tr[3]//tr[1]//td[2]//table[1]//tr[2]//tr//a/text()').map(&:to_s)
    @data_to_save = url_a.zip(names_a).map do |turl, town_name|
      Hash["#{town_name.to_s}": em_finder(page_url.gsub(/val-d-oise\.html/, '') +
        turl.gsub(/\A\./, ''))]
    end
  end

  def save_as_JSON
    File.open("db/emails.json","w") { |f| f << @data_to_save.to_json }
  end

  def save_as_spreadsheet
    session = GoogleDrive::Session.from_config("config.json")
    spreadsheet = session.create_spreadsheet(title = "cities")
    ws = spreadsheet.worksheets[0]
    ws[1,1] = "Ville"
    ws[1, 2] = "E-mail"
    binding.pry
    @data_to_save.each_entry.with_index { |k, i| ws[i+2,1] = k.keys }
    @data_to_save.each_entry.with_index { |v, i| ws[i+2,2] = v.values }
    ws.save()
  end

  def save_as_csv
    CSV.open("db/emails.csv", "wb", {col_sep: ","}) do
      |csv| @data_to_save.collect! { |town_email_hash|
        town_email_hash.to_a.flatten
      }.each { |town_email_array| csv << town_email_array }
    end
  end

  private

  def em_finder(townhall_url)
    Nokogiri::HTML(open(townhall_url.to_s)).xpath('//tbody[1]
      //tr[4]/td[2]/text()').first.to_s
  end
end
