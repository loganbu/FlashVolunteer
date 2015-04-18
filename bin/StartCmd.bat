@REM Command script to run to set up all environment variables.

@REM Username and password for an e-mail account that can send e-mail
set MAILER_USERNAME=
set MAILER_PASSWORD=

@REM Default password for the super-admin created
set ADMIN_PASSWORD=

@REM S3 info for images
set AWS_ACCESS_KEY=
set AWS_SECRET_KEY=
set AWS_BUCKET=

@REM ImageMagick information
@REM see http://www.imagemagick.com/www/binary-releases.html#windows
@REM and http://stackoverflow.com/questions/4451213/ruby-1-9-2-how-to-install-rmagick-on-windows
set DFImageMagick=c:\ImageMagick
set PATH=%DFImageMagick%;%PATH%
set CPATH=%DFImageMagick%\include;%CPATH%
set LIBRARY_PATH=%DFImageMagick%\lib;%LIBRARY_PATH%

set FACEBOOK_API_KEY=
set FACEBOOK_API_SECRET=