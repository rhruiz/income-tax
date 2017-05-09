defmodule Ir.Spec do
  use ESpec, shared: true

  subject do: calculator().(salary(), method())

  let :precision, do: 0.02

  context "in the free range" do
    let :salary, do: 1200.00
    let :expected, do: 0.00

    it "is zero" do
      expected(subject()).to(be_close_to expected(), precision())
    end
  end
end
