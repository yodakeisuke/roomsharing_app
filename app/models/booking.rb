class Booking < ApplicationRecord

  require 'bigdecimal'
  require "date"

  belongs_to :user
  belongs_to :room

  validates :number_of_users, presence: true, numericality: { in: 1..999 }
  validates :start_date, presence: true
  validates :termination_date, presence: true

  validate  :validate_overdue_now
  validate  :validate_overdue_start_date

  TAX_RATE = "1.1"
  attr_accessor :days_of_use

  def sum_up_total_charge
    self.days_of_use = (self.termination_date - self.start_date).to_i
    self.room = Room.find(room_id)
    self.total_charge = (BigDecimal(self.room.charge.to_s) * BigDecimal(self.days_of_use.to_s) * BigDecimal(self.number_of_users.to_s) * BigDecimal(TAX_RATE)).ceil
  end

  def start_date_formated
    start_date.strftime("%Y年 %m月 %d日")
  end

  def termination_date_formated
    termination_date.strftime("%Y年 %m月 %d日")
  end

  private

    def validate_overdue_now
      return if start_date.nil?
      errors.add(:start_date, "が現在日付の過去です") if start_date.strftime("%x") < DateTime.current.strftime("%x")
    end

    def validate_overdue_start_date
      return if start_date.nil?
      return if termination_date.nil?
      errors.add(:termination_date, "が開始日の同日か過去です") if termination_date <= start_date
    end

end
