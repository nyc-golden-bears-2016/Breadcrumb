class Crumb < ApplicationRecord
  paginates_per 15

  belongs_to :trail

  has_attached_file :img, required: false

  validates_attachment_content_type :img,
                                    :content_type => /^image\/(png|gif|jpeg)/,
                                    :message => 'only (png/gif/jpeg) images',
                                    :size => { in: 0..2.megabytes }

  has_attached_file :sound, required: false

  validates_attachment_content_type :sound,
                             :content_type => [
  'audio/mpeg',
  ['audio/mpeg'], # note the array around the type
  'audio/mp3'
],
                             :message => 'only .mpeg or .wav files',
                             :size => { in: 0..4.megabytes }


	validates :name, { presence: true }
end
