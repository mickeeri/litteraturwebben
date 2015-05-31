class Article < ActiveRecord::Base
    belongs_to :book
    belongs_to :author

    # Validation
    validates :title, presence: { message: "Titel måste anges."},
        length: { maximum: 50, message: "Titeln får inte överstiga 50 tecken."}
    validates :year, presence: { message: "Du måste ange ett datum/årtal."}
    validates :writer, presence: { message: "Upphovsman måste anges." } , length: { maximum: 50, message: "Upphovsman: max 50 tecken."}
    validates :source, presence: { message: "Källa måste anges." } , length: { maximum: 30, message: "Källa: max 50 tecken." }
    validates :about, length: { maximum: 350, message: "Beskrivning: max 350 tecken." }
    validates :url, length: { maximum: 100, message: "Url: max 100 tecken." }

    #book_id must be present unless author_id is present and vice-versa.
    # http://guides.rubyonrails.org/active_record_validations.html#using-a-proc-with-if-and-unless
    validates :book_id, presence: true, :unless => Proc.new { |a| a.author_id? }
    validates :author_id, presence: true, :unless => Proc.new { |a| a.book_id? }
end
