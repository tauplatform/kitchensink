require 'rho'
require 'rho/rhocontroller'
require 'rho/rhoerror'
require 'helpers/browser_helper'

class FileController < Rho::RhoController
  include BrowserHelper
  def browse_filesystem
    if (Rho::System.platform != "ANDROID")
        @start_from_path = @params["start_from_path"] || Rho::Application.appsBundleFolder
    else
        @start_from_path = @params["start_from_path"] || "/mnt/sdcard"
    end
 
    @folders = []
    @files = []

    # TODO: move from RhoFile to File when implemented
    @entries = Rho::RhoFile.listDir(@start_from_path)

    @entries.each do |entry|
      unless (entry == "." || entry == "..")
        (Rho::RhoFile.isDir(Rho::RhoFile.join(@start_from_path,entry)) ? @folders : @files) << entry
      end
    end

    render
  end

end
