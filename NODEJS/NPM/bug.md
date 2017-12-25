## BUG

    D:\Sources\DownloadCms\Md.Download\Web.Angular>npm install mds.angular.datetimepicker@latest --save
    npm ERR! path D:\Sources\DownloadCms\Md.Download\Web.Angular\node_modules\fsevents\node_modules\abbrev\package.json
    npm ERR! code EPERM
    npm ERR! errno -4048
    npm ERR! syscall unlink
    npm ERR! Error: EPERM: operation not permitted, unlink 'D:\Sources\DownloadCms\Md.Download\Web.Angular\node_modules\fsevents\node_modules\abbrev\package.json'
    npm ERR!     at Error (native)
    npm ERR!  { Error: EPERM: operation not permitted, unlink 'D:\Sources\DownloadCms\Md.Download\Web.Angular\node_modules\fsevents\node_modules\abbrev\package.jso
    n'
    npm ERR!     at Error (native)
    npm ERR!   stack: 'Error: EPERM: operation not permitted, unlink \'D:\\Sources\\DownloadCms\\Md.Download\\Web.Angular\\node_modules\\fsevents\\node_modules\\ab
    brev\\package.json\'\n    at Error (native)',
    npm ERR!   errno: -4048,
    npm ERR!   code: 'EPERM',
    npm ERR!   syscall: 'unlink',
    npm ERR!   path: 'D:\\Sources\\DownloadCms\\Md.Download\\Web.Angular\\node_modules\\fsevents\\node_modules\\abbrev\\package.json' }
    npm ERR!
    npm ERR! Please try running this command again as root/Administrator.

    npm ERR! A complete log of this run can be found in:
    npm ERR!     C:\Users\Mohammad\AppData\Roaming\npm-cache\_logs\2017-09-03T03_25_50_432Z-debug.log


## 解决：
    downgrade to 5.3
    npm install --no-optional
    npm i @types/jquery --save-dev --no-optional