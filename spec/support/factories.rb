FactoryGirl.define do
  to_create do |instance|
    if !instance.save
      raise "Save failed for #{instance.class}"
    end
  end

  factory :cart, class: OnOff::API::Models::Cart do
  end

  factory :device_group, class: OnOff::API::Models::DeviceGroup do
    sequence(:title) { |n| "DeviceGroup ##{n}"}
  end

  factory :device, class: OnOff::API::Models::Device do
    device_group

    sequence(:code) { |n| "Code ##{n}"}
    sequence(:title) { |n| "Title ##{n}"}
    index 1

    trait :visible_device do
      display_on_page true
    end
  end

  factory :cart_item, class: OnOff::API::Models::CartItem do
    cart
    device

    amount 1

    trait :new do
      cart nil
    end
  end

  factory :manufacturer, class: OnOff::API::Models::Manufacturer do
    sequence(:title)    { |n| "Title ##{n}" }
    sequence(:country)  { |n| "Country ##{n}" }
  end

  factory :series, class: OnOff::API::Models::Series do
    manufacturer

    sequence(:title) { |n| "Series ##{n}" }
  end

  factory :parameter, class: OnOff::API::Models::Parameter do
    series

    sequence(:variable) { |n| "Variable #{n}"}
    sequence(:description) { |n| "Description #{n}"}
  end

  factory :value, class: OnOff::API::Models::Value do
    parameter

    sequence(:code) { |n| "Code #{n}"}
    sequence(:description) { |n| "Description #{n}"}
    selected { rand > 0.5 }
  end

  factory :device_series, class: OnOff::API::Models::DeviceSeries do
    device
    series
  end

  factory :sku, class: OnOff::API::Models::SKU do
    sequence(:title) { |n| "SKU ##{n}" }
  end

  factory :device_series_sku, class: OnOff::API::Models::DeviceSeriesSKU do
    sku
    device_series

    amount      { rand(1..4) }
    unit_price  { rand(1..100.0) }
  end

  factory :sku_parameter, class: OnOff::API::Models::SKUParameter do
    device_series_sku
    parameter
  end

  factory :sku_value, class: OnOff::API::Models::SKUValue do
    sku_parameter
    value

    sequence(:compiled_title) { |n| "Compiled title #{n}"}
    sequence(:description) { |n| "Description #{n}"}
    unit_price  { rand(1..100.0) }
  end
end