# frozen_string_literal: true

# rubocop:disable Style/ClassAndModuleChildren
class Maglev::Section::Block
  ## concerns ##
  include ActiveModel::Model

  ## attributes ##
  attr_accessor :name, :type, :parent_id, :settings

  ## validation ##
  validates :name, :type, presence: true
  validates :settings, 'maglev/collection': true

  ## class methods ##

  def self.build(hash)
    attributes = hash.slice('name', 'type')

    new(
      attributes.merge(
        settings: Maglev::Section::Setting.build_many(hash['settings'])
      )
    )
  end

  def self.build_many(list)
    return [] if list.blank?

    list.map { |hash| build(hash) }
  end
end
# rubocop:enable Style/ClassAndModuleChildren
