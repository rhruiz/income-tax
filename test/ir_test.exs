defmodule IRTest do
  use ExUnit.Case

  import IR, only: [tax: 1]

  test "up to 1903.98 tax should be 0" do
    assert tax(1903.98) == 0.0
    assert tax(1500) == 0.0
    assert tax(150) == 0.0
    assert tax(15) == 0.0
    assert tax(1) == 0.0
    assert tax(0) == 0.0
  end

  test "in the 7.5% range should be deducted 142.80" do
    assert tax(2000.0) == Float.round(2000*0.075 - 142.80, 2)
  end

  test "in the 15% range should be deducted 354.80" do
    assert tax(3000.0) == Float.round(3000*0.15 - 354.80, 2)
  end

  test "in the 22.5% range should be deducted 636.13" do
    assert tax(4000.0) == Float.round(4000*0.225 - 636.13, 2)
  end

  test "in the 27.5% range should be deducted 869.36" do
    assert tax(5000.0) == Float.round(5000*0.275 - 869.36, 2)
  end

  test "tax for 1903.99 should be 0" do
    assert tax(1903.99) == 0.0
  end

  test "tax for 2826.65 should be 69.20" do
    assert tax(2826.65) == 69.20
  end

  test "tax for 3751.06 should be 207.86" do
    assert tax(3751.06) == 207.86
  end

  test "tax for 5000.0 should be 505.64" do
    assert tax(5000.0) == 505.64
  end
end
