class FixedDepositDetailsDecorator

  def initialize(fd_details)
    @fd_details = fd_details
  end

  def self.custom_decorate(fd_details)
    new(fd_details)
  end

  def top_five_public_sector
    @fd_details.select {|fd_detail| fd_detail.sector == "public" || fd_detail.sector == "PUBLIC"}.take(5)
  end

  def top_five_private_sector
    @fd_details.select {|fd_detail| fd_detail.sector == "private" || fd_detail.sector == "PRIVATE"}.take(5)
  end
end
