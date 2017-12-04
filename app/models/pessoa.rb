# == Schema Information
#
# Table name: pessoas
#
#  id              :integer          not null, primary key
#  cns             :string(16)       not null
#  nome_completo   :string(255)      not null
#  data_nascimento :date             not null
#  email           :string(100)
#  senha           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Pessoa < ApplicationRecord
  include BCrypt

  has_one :medico, dependent: :destroy
  has_many :atendimentos, dependent: :destroy
  has_many :permissoes, dependent: :destroy, class_name: 'Permissao'

  validates :cns, presence: true,
                  length: { is: 16 },
                  uniqueness: { case_sensitive: false }

  validates :nome_completo, presence: true,
                            length: { maximum: 255 }

  validates :data_nascimento, presence: true
  validates :email, email: true,
                    length: { maximum: 100 },
                    allow_blank: true,
                    uniqueness: { case_sensitive: false }

  validates :senha, length: { minimum: 6, maximum: 10 }, if: :senha_changed?

  validate :validate_email_account, :validate_senha_account

  before_save :encrypt_senha

  def correct_senha?(value)
    return false if senha.blank?
    BCrypt::Password.new(senha) == value
  end

  private

  def validate_email_account
    errors.add(:email, 'can\'t be blank') if email.blank? && senha.present?
  end

  def validate_senha_account
    errors.add(:senha, 'can\'t be blank') if email.present? && senha.blank?
  end

  def encrypt_senha
    return unless senha_changed?
    self.senha = BCrypt::Password.create(senha) if senha.present?
  end
end
