class PagesController < ApplicationController
  def home
  end

  def services
    @jobs = [
      { name: "Tune-up", price: 45 },
      { name: "Brake bleed", price: 35 },
      { name: "Chain replacement", price: 30 },
      { name: "Flat tyre repair", price: 15 },
      { name: "Gear adjustment", price: 20 },
      { name: "Brake pad replacement", price: 25 },
      { name: "Bottom bracket service", price: 40 },
      { name: "Full service", price: 90 },
      { name: "Tyre replacement", price: 20 },
      { name: "Cable replacement", price: 18 },
      { name: "Spoke replacement", price: 12 },
      { name: "Suspension fork service", price: 60 },
      { name: "Disc brake rotor truing", price: 15 }
    ]
  end

  def visiting
  end

  def about
  end
end