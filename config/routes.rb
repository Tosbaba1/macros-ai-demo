Rails.application.routes.draw do

  get("/blank_form", { :controller => "food", :action => "estimate" })

  post("/macro_results", { :controller => "food", :action => "results" })

  # Solutions below. Don't peek until you try it yourself and get stuck!

  get("/solutions/blank_form", { :controller => "solutions", :action => "display_form" })
  
  post("/solutions/process_form", { :controller => "solutions", :action => "process_inputs" })
  
end
