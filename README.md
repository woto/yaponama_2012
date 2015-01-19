Yaponama 2012

=============

Изменение закупочной и продажной цен и количества в различных статусах.
-

Через дробь первое значение - сумма, второе - количество.

- "0" Означает, что изменение этого поля никак не влияет на долг.
- "Y" Означает возможность изменения этого поля и влечет за собой изменение долга.
- "N" Означает отсутствие возможности изменения этого поля.

<table>
    <tr>
        <td>Статус</td>
        <td>Изм. продажной</td>
        <td>Изм. закупочной цены</td>
    </tr>
    <tr>
        <td>incart</td>
        <td>0/0</td>
        <td>0/0</td>
    </tr>
    <tr>
        <td>inorder</td>
        <td>0/0</td>
        <td>0/0</td>
    </tr>
    <tr>
        <td>ordered</td>
        <td>Y/Y</td>
        <td>0/0</td>
    </tr>
    <tr>
        <td>pre_supplier</td>
        <td>Y/Y</td>
        <td>0/0</td>
    </tr>
    <tr>
        <td>post_supplier</td>
        <td>Y/Y</td>
        <td>Y/Y</td>
    </tr>
    <tr>
        <td>stock</td>
        <td>Y/N</td>
        <td>N/N</td>
    </tr>
    <tr>
        <td>complete</td>
        <td>N/N</td>
        <td>N/N</td>
    </tr>
    <tr>
        <td>cancel</td>
        <td>N/N</td>
        <td>N/N</td>
    </tr>  
</table>

Например у товара в статусе stock можно изменить продажную цену, но нельзя поменять закупочную цену и количество.

Переходы статусов
-----------------

<table>
    <tr>
        <td></td>
        <td>incart</td>
        <td>inorder</td>
        <td>ordered</td>
        <td>pre_supplier</td>
        <td>post_supplier</td>
        <td>stock</td>
        <td>complete</td>
        <td>cancel</td>
    </tr>
    <tr>
        <td>incart</td>
        <td>0/0/0/0</td>
        <td>0/0/0/0</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>0/0/0/0</td>
    </tr>
    <tr>
        <td>inorder</td>
        <td>0/0/0/0</td>
        <td>0/0/0/0</td>
        <td>+/+A/0/0</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>0/0/0/0</td>
    </tr>
    <tr>
        <td>ordered</td>
        <td>-/0/0/0</td>
        <td>-/0/0/0</td>
        <td>X</td>
        <td>0/0/0/0</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>-/0/0/0</td>
    </tr>
    <tr>
        <td>pre_supplier</td>
        <td>-/0/0/0</td>
        <td>-/0/0/0</td>
        <td>X</td>
        <td>0/0/0/0</td>
        <td>0/0/+/0</td>
        <td>X</td>
        <td>X</td>
        <td>-/0/0/0</td>
    </tr>
    <tr>
        <td>post_supplier</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>0/0/-/0</td>
        <td>0/0/-+B/0</td>
        <td>0/0/-/-</td>
        <td>X</td>
        <td>-/0/-/0</td>
    </tr>
    <tr>
        <td>stock</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>0/0/+C/+C</td>
        <td>X</td>
        <td>-/-/0/0</td>
        <td>-/0/0/0</td>
    </tr>    
    <tr>
        <td>complete</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>X</td>
        <td>+/+/0/0</td>
        <td>X</td>
        <td>0/0/0/0</td>
    </tr>
    <tr>
        <td>cancel</td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
    </tr>  
</table>

Значения ячеек:

- "X" Невозможность смены статуса.
- Четыре значения по-порядку:
    1. В работе у покупателя;
    2. Счет покупателя;
    3. В работе у поставщика;
    4. Счет поставщика.

Обозначения:

- "-" Уменьшение суммы
- "+" Увеличение суммы
- "0" Не влияет на сумму
- "A" Произвольная сумма на усмотрение менеджера.
- "B" Если меняется поставщик, то меняются и суммы. Если нет, то нет.
- "C" Только тому же поставщику у которого был оформлен заказ.

incart <-> inorder - Офомрление заказа. Указание способа доставки, адреса и т.д. Либо перекидывание обратно из заказа.
inorder <-> inorder - Перемещение в друго заказ.
ordered <-> pre_supplier (и более) - Блокировка возможности отказа клиентом от заказа.
inorder -> ordered - Вводе фактически внесенных средств рассчитывается исходя из способа доставки (100% по почте например) или автоматический перевод в зависимости от "правила предоплаты"
pre_supplier -> cancel (и более) отмена долга клиента доступна только менеджеру

1. Проверить допустимость переходов статусов на базе обработки в контроллерах
2. Проверить с разными покупателями/поставщиками
3. Изменение цен в разных статусах
4. Доработать ошибочные смены статусов (обратный ход)
5. Обработать отказ с любого шага
6. Обдумать еще раз над статусами: отказ поставщика, возврат, мой отказ, отказ покупателя

TODO
----

- Дозаказ
- Отказ (мой  поставщика)
- Привязка к реальным ценам (отслеживание изменений: цены, срока, кол-ва)
- Код идентификации оплаты
- Денег достаточно только на одну деталь заказа
- Отправления
- Выдача (разбивка на отправления?)
- Отправка поставщику
- Стоимость доставки
- Почта - наложенный платеж (фикс. возврата средств)
- Выдал товар, но не получил $
- Статус заказа - умопл. (когда уже нельзя добавить в заказ)


---


- TODO потом разобраться с автоматическим подставлением имени
- message[:from].display_names.first
- :name => message[:from].addrs.collect{|a| a.display_name}
- http://stackoverflow.com/questions/5940847/using-rails-3-mail
- http://dansowter.com/mailman-guide/
- http://guides.rubyonrails.org/action_mailer_basics.html
- https://github.com/titanous/mailman/blob/master/USER_GUIDE.md
- https://github.com/mikel/mail
- http://stackoverflow.com/questions/9094872/how-to-process-incoming-mails-using-mailman-and-update-them-into-the-database
- https://github.com/titanous/mailman
- Mail::AddressContainer
- Mail::Field
- Mail::Message
- --
- http://steve.dynedge.co.uk/2010/11/29/receiving-test-driven-incoming-email-for-rails-3/

---

Postgres + Spec
-

- http://kerryb.github.com/iprug-rspec-presentation/#27
- http://rspec.info/
- https://github.com/rspec/rspec
- http://rspec.info/
- https://github.com/thoughtbot/factory_girl/blob/master/GETTING_STARTED.md
- http://rubydoc.info/gems/rspec-rails/frames
- https://github.com/jnicklas/capybara
- http://www.youtube.com/watch?v=qMpF3eMq_Kc&feature=g-wl&list=WLCBC1429D9ADDF173

node redis juggernaut socket.io
http://dev.mensfeld.pl/2010/05/juggernaut-rails-chat-part-i-what-is-and-how-to-install/
http://blog.moove-it.com/juggernaut-chat-on-rails/
http://www.golygon.com/2010/12/private-chat-room-in-ruby-on-rails-3-0/

http://code.google.com/p/jqueryrotate/wiki/Examples

http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
http://guides.rubyonrails.org/active_record_validations_callbacks.html
http://api.rubyonrails.org/classes/ActiveRecord/Associations/ClassMethods.html
http://api.rubyonrails.org/classes/ActiveRecord/Locking/Pessimistic.html
http://api.rubyonrails.org/classes/ActiveModel/Dirty.html
http://api.rubyonrails.org/classes/ActiveRecord/Relation.html#method-i-update_all
http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-destroyed-3F
http://api.rubyonrails.org/classes/ActiveRecord/Base.html#M002337


https://github.com/ryanb/cancan/wiki/defining-abilities
https://github.com/ryanb/cancan/wiki/checking-abilities
https://github.com/ryanb/cancan/wiki/authorizing-controller-actions
https://github.com/ryanb/cancan/wiki/Accessing-request-data
https://github.com/ryanb/cancan

http://railscasts.com/episodes/274-remember-me-reset-password?view=asciicast
http://railscasts.com/episodes/356-dangers-of-session-hijacking?view=asciicast
http://railscasts.com/episodes/393-guest-user-record?view=asciicast
http://railscasts.com/episodes/192-authorization-with-cancan?view=asciicast
http://railscasts.com/episodes/250-authentication-from-scratch
http://stackoverflow.com/questions/6336332/password-digest-has-secret-password-and-form-validations-in-ror-3-1





SANITIZE

https://github.com/rgrove/sanitize/network
https://github.com/rubyworks/htmlfilter/tree/master/test
https://github.com/flavorjones/loofah/network
https://www.google.ru/search?q=sanitize+vs+loofah&oq=sanitize+vs+loofah&aqs=chrome.0.57j62.3966&sugexp=chrome,mod=0&sourceid=chrome&ie=UTF-8#hl=ru&newwindow=1&tbo=d&sclient=psy-ab&q=loofah+inline+css&oq=loofah+inline+css&gs_l=serp.3...131973.131973.1.132213.1.1.0.0.0.0.63.63.1.1.0...0.0...1c.1.7zMtLzmabW0&pbx=1&fp=1&bpcl=40096503&biw=1280&bih=679&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&cad=b&sei=7U3jUInoL83Z4QTB24HIDA
https://github.com/flavorjones/loofah/pull/31
https://github.com/presidentbeef/brakeman
https://github.com/flavorjones/loofah/tree/master/test/assets
http://htmlpurifier.org/demo.php?post
https://github.com/vjt/sanitize-rails
http://htmlpurifier.org/
https://www.google.ru/search?q=sanitizing+inline+css&oq=sanitizing+inline+css&aqs=chrome.0.57j62l3.4330&sugexp=chrome,mod=0&sourceid=chrome&ie=UTF-8
http://stackoverflow.com/questions/3241616/sanitize-user-defined-css-in-php
http://stackoverflow.com/questions/1162918/strip-inline-css-and-javascript-in-rails
https://supportbee.com/devblog/2011/08/15/sanitizing-css-in-rails/
https://github.com/snikch/jquery.dirtyforms/issues/10
https://github.com/snikch/jquery.dirtyforms/issues/12
https://groups.google.com/forum/?fromgroups=#!topic/twitter-bootstrap/nxq0HaBpsqU

CKEDITOR

http://peterpetrik.com/blog/remove-tabs-and-elements-from-ckeditor-dialog-window
http://stackoverflow.com/questions/1794219/ckeditor-instance-already-exists

SOCKET.IO
chat https://github.com/liamks/Chatty

http://liamkaufman.com/blog/2012/02/25/adding_real-time_to_rails_with_socket.IO_nodejs_and_backbonejs_with_demo/
https://github.com/liamks/Chatty
https://github.com/nhunzaker/backbone-socket.io-examples
http://fzysqr.com/2011/02/28/nodechat-js-using-node-js-backbone-js-socket-io-and-redis-to-make-a-real-time-chat-app/
http://blog.andyet.com/2011/feb/15/re-using-backbonejs-models-on-the-server-with-node/
https://github.com/scttnlsn/backbone.io
https://github.com/logicalparadox/backbone.iobind
https://github.com/codebrew/backbone-rails
https://github.com/meleyal/backbone-on-rails
https://github.com/DanielBaulig/chat.io
https://www.google.ru/search?q=rails+replacement+socket.io&oq=rails+replacement+socket.io&aqs=chrome.0.57j62l2j64.10118&sourceid=chrome&ie=UTF-8
https://github.com/LearnBoost/socket.io
https://www.google.ru/search?q=io+on+of&oq=io+on+of&aqs=chrome.0.57j0l2j60l2j61.2636&sourceid=chrome&ie=UTF-8#hl=ru&newwindow=1&tbo=d&sclient=psy-ab&q=socket++io+on+%22of%22+method&oq=socket++io+on+%22of%22+method&gs_l=serp.3...21120.26390.2.26507.11.10.1.0.0.0.163.712.9j1.10.0...0.0...1c.1.2.serp.Js5y3ZGLJyA&psj=1&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&bvm=bv.41867550,d.bGE&fp=c33bac997a2f0e57&biw=1280&bih=635
https://www.google.ru/search?q=socket+id+broadcast+emit&oq=socket+id+broadcast+emit&aqs=chrome.0.57j62l3.5877&sourceid=chrome&ie=UTF-8#q=socket.io+methods+id+broadcast+emit&hl=ru&newwindow=1&tbo=d&psj=1&ei=FSQMUaXgE-X-4QSw2oHICw&start=10&sa=N&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&bvm=bv.41867550,d.bGE&fp=c33bac997a2f0e57&biw=1280&bih=635
http://habrahabr.ru/post/127525/
https://www.google.ru/search?q=socket.io+who+were+disconnected&oq=socket.io+who+were+disconnected&aqs=chrome.0.57j62l3.6998&sourceid=chrome&ie=UTF-8#q=socket.io+who+were+disconnected&hl=ru&newwindow=1&tbo=d&psj=1&ei=liMMUd2MNsKt4ATYnoGYAg&start=10&sa=N&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.&bvm=bv.41867550,d.bGE&fp=c33bac997a2f0e57&biw=1280&bih=635
https://github.com/LearnBoost/socket.io-client
https://github.com/liamks/Chatty-Node-Server/blob/master/chat-server.js
https://www.google.ru/search?q=handlebars.js&oq=handlebars.js&aqs=chrome.0.57j59j0j60j61j0.4422&sourceid=chrome&ie=UTF-8
http://addyosmani.github.com/backbone-fundamentals/#collections
https://github.com/codebrew/backbone-rails/tree/master/lib

# JUGGERNAUT REDIS ...
https://github.com/maccman/juggernaut/issues/80
https://github.com/maccman/juggernaut
http://www.google.com/search?client=safari&rls=en&q=nodejs+juggernaut+lister&ie=UTF-8&oe=UTF-8#q=juggernaut+nodejs+listen&hl=en&client=safari&rls=en&prmd=imvns&ei=KMCBT_O8MNHoOZLNxO4G&start=10&sa=N&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.,cf.osb&fp=f85e188e4be29462&biw=1280&bih=664
https://github.com/maccman/holla/blob/original/app/javascripts/application.juggernaut.js
https://github.com/mranney/node_redis
http://www.google.com/search?client=safari&rls=en&q=redis+create+client+subscribe+message&ie=UTF-8&oe=UTF-8
http://localhost:3000/info/1780103010/TOYOTA
http://mrjaba.posterous.com/a-gentle-introduction-to-nodejs
http://www.stoimen.com/blog/2010/11/16/diving-into-node-js-introduction-and-installation/
http://stackoverflow.com/questions/5062614/how-to-decide-when-to-use-nodejs
http://caolanmcmahon.com/posts/writing_for_node_and_the_browser
http://stackoverflow.com/questions/3225251/how-can-i-share-code-between-node-js-and-the-browser
http://stackoverflow.com/questions/5050265/javascript-nodejs-is-array-foreach-asynchronous
http://www.adequatelygood.com/2010/2/JavaScript-Scoping-and-Hoisting
https://github.com/dannycoates/node-inspector
http://127.0.0.1:8080/debug?port=5858

# Ссылки с Safari
http://www.emex.ru/catalogs/aftermarket
http://www.maslenka66.ru/brand
http://www.brakepads.ru/brand/
http://www.autolink.by/brand/t/
http://gid-vladimir.narod.ru/auto5.html
http://autozapchasti24.ru/brands/
http://запчасти-юг.рф/Все-марки/
https://github.com/mbulat/plutus
http://www.gliffy.com/gliffy/#
http://wsdoc.emex.ru
http://www.biznet.ru/topic164895s50.html
http://www.pythontutor.com/visualize.html
http://habrahabr.ru/post/125988/
http://habrahabr.ru/post/149420/
http://habrahabr.ru/post/121032/
http://habrahabr.ru/post/68341/
http://githowto.com/ru
http://pastebin.com/TyPB9sEh
http://habrahabr.ru/company/sprinthost/blog/129560/
http://habrahabr.ru/company/mosigra/blog/113876/
http://habrahabr.ru/company/infopulse/blog/133303/
http://habrahabr.ru/post/63854/
http://www.lektorium.tv
http://habrahabr.ru/post/126373/
http://habrahabr.ru/post/114082/
http://habrahabr.ru/post/64535/
http://habrahabr.ru/post/74326/
http://habrahabr.ru/post/137206/
http://habrahabr.ru/post/138053/
http://habrahabr.ru/post/138513/
http://habrahabr.ru/post/139132/
http://habrahabr.ru/post/140939/
http://habrahabr.ru/company/radmin/blog/137497/
http://habrahabr.ru/post/140581/
http://habrahabr.ru/post/141501/
http://habrahabr.ru/post/143102/
http://habrahabr.ru/post/145835/
http://habrahabr.ru/post/144614/
http://habrahabr.ru/post/148365/
http://habrahabr.ru/post/146903/
http://habrahabr.ru/post/122445/
http://habrahabr.ru/post/142128/
http://habrahabr.ru/post/140684/
http://habrahabr.ru/post/141124/
http://habrahabr.ru/post/141180/
http://habrahabr.ru/post/143127/
http://habrahabr.ru/post/143483/
http://habrahabr.ru/post/143990/
http://habrahabr.ru/post/146405/
http://habrahabr.ru/post/148525/
http://habrahabr.ru/company/yandex/blog/148737/
http://habrahabr.ru/post/147745/
http://habrahabr.ru/post/147250/
http://habrahabr.ru/post/149315/
http://habrahabr.ru/post/148829/
http://habrahabr.ru/post/148002/
http://habrahabr.ru/post/149082/
http://habrahabr.ru/post/148365/
http://habrahabr.ru/post/148089/
http://habrahabr.ru/post/147996/
http://habrahabr.ru/post/148407/
http://habrahabr.ru/post/148124/
http://www.akadia.ru/about/promo/4/
http://www.siteposition.ru
http://brainspec.com/blog/2012/06/28/activemerchant-robokassa/
http://dom-podarka.ru/about-company/payment/
http://z-payment.com
http://sprypay.ru
http://onpay.ru
http://www.onlinedengi.ru/paysystems
http://www.platron.ru
http://www.mig-pay.com/formerchant/
http://www.sbank.ru/manual_SBANK.RU.pdf
http://www.siteposition.ru/check.php
http://ovsyannikoff.ru/seo/analiz-konkurentov
http://great-world.ru/analiz-konkurentov-sajta-i-poiskovyx-zaprosov/
http://www.thegeekstuff.com/2011/09/linux-htop-examples/
http://forum.ubuntu.ru/index.php?topic=186509.0
http://forum.ubuntu.ru/index.php?topic=190853.0
http://cdimage.ubuntu.com/releases/12.04/release/
http://bestpartnerki.com/dir/partnerki_internet_magazinov/partnerki_raznykh_magazinov/12-2-14
http://www.liveinternet.ru/rating/ru/auto/index.html?page=2
http://yandex.ru/yandsearch?text=site%3Awww.rsmart.ru&lr=213
http://msk.rsmart.ru
http://ad1.ru
http://cityads.ru
http://en.wikipedia.org/wiki/K-nearest%5Fneighbor%5Falgorithm
http://ejohn.org/blog/ocr-and-neural-nets-in-javascript/
http://www.neuroforge.co.uk/index.php/input-and-output-with-open-cv
http://experienceopencv.blogspot.ru/2011/01/flann.html
http://blog.damiles.com/2008/11/basic-ocr-in-opencv/
http://www.aishack.in/2010/10/k-nearest-neighbors-in-opencv/
http://szeliski.org/Book/
http://www.unix-ag.uni-kl.de/~auerswal/ssocr/
http://habrahabr.ru/post/112960/
http://habrahabr.ru/post/113073/
http://stackoverflow.com/questions/7877282/how-to-send-image-generated-by-pil-to-browser
http://www.mxtoolbox.com/SuperTool.aspx?action=blacklist%3a78.47.165.69#
http://msgpack.org
http://myopencv.wordpress.com/2009/06/13/detecting-colors-using-rgb-color-space/
http://habrahabr.ru/post/104475/
http://myopencv.wordpress.com/2009/06/13/detecting-colors-using-rgb-color-space/
http://habrahabr.ru/hub/artificial_intelligence/posts/
http://www.gosuslugi.ru/pgu/cat/MAIN_CLASS_A.html#online
https://www.moedelo.org/Pro/View/FormsRubric/23
http://market.yandex.ru/catalog.xml?hid=90402
http://nlp.stanford.edu/links/statnlp.html
http://mendicantbug.com/2009/09/13/nlp-resources-for-ruby/
http://en.wikipedia.org/wiki/List_of_natural_language_processing_toolkits#Natural_language_processing_toolkits
http://www.mossgup.ru/aren_ftb.asp
http://www.b-kontur.ru/enquiry/6
http://bazazakonov.ru/doc/?ID=2769655
http://www.autogroom.ru
http://www.nomer.org/mosgibdd/
http://www.phreaker.us/forum/showthread.php?t=5493&page=387
http://forum.antichat.ru/thread274632-%E3%E8%E1%E4%E4.html
http://www.fractus.ru/ebooks/21125-abonents-base-russia-abonentskaya-baza-rossiya-20102011-v50-final-16-gb.html
http://www.printom.ru/price/
http://forum.print-forum.ru/forumdisplay.php?f=143
http://www.biznet.ru
http://forum.japancar.ru/viewforum.php?f=62
http://www.partnersearch.ru/business/viewtopic.php?t=27657
http://forum.good-business.ru/viewtopic.php?f=47&t=1027
http://shop.amayama.ru
http://top.mail.ru/Rating/Cars-Spare/Today/Visitors/4.html#101
http://www.uploadify.com
http://stackoverflow.com/questions/166221/how-can-i-upload-files-asynchronously-with-jquery
http://h20000.www2.hp.com/bizsupport/TechSupport/Document.jsp?objectID=c02273848&lang=en&cc=us&taskId=&prodSeriesId=4023238&prodTypeId=18972
http://h20000.www2.hp.com/bizsupport/TechSupport/Document.jsp?lang=en&cc=us&taskId=120&prodSeriesId=4023238&prodTypeId=18972&objectID=c02187393
http://www.linepart.ru/?code=16620-28070&action=catalog_price_view&order=code&way=asc
# Авторизация
http://railscasts.com/episodes/304-omniauth-identity?view=asciicast
http://railscasts.com/episodes/304-omniauth-identity?view=asciicast
http://railscasts.com/episodes/241-simple-omniauth
http://bernardi.me/2012/09/using-multiple-omniauth-providers-with-omniauth-identity-on-the-main-user-model/
http://railscasts.com/episodes/236-omniauth-part-2
http://railscasts.com/episodes/235-omniauth-part-1
http://blog.railsrumble.com/2010/10/08/intridea-omniauth/
http://blog.railsrumble.com/2010/10/08/intridea-omniauth/
https://github.com/jamiew/omniauth-rails-app/issues
http://habrahabr.ru/company/darudar/blog/143188/
http://7vn.ru/blog/2012/09/09/vkontakte-async/
http://habrahabr.ru/post/151585/
http://rubysource.com/get-your-app-ready-for-rails-4/
https://github.com/caolan/async
http://nodejs.org/about/
# Связь
http://www.rossvyaz.ru/activity/num_resurs/registerNum/
http://adhearsion.com/community
https://github.com/adhearsion/adhearsion
ftp://ftp.university.kg/pub/sip/asterisk/Asterisk_RU_OReilly_DRAFT.pdf
http://www.asteriskdocs.org/en/3rd_Edition/asterisk-book-html-chunk/
https://wiki.asterisk.org/wiki/display/AST/Asterisk+11+Documentation
http://astbook.asteriskdocs.org/en/3rd_Edition/asterisk-book-html/asterisk-book.html#Internationalization_id305831
http://forums.asterisk.org/viewtopic.php?p=155594

Отображение профиля пользователя (одна страница, а на ней телефон, имя и т.д.)
http://gridster.net/







http://jamesflorentino.github.io/nanoScrollerJS/
https://github.com/rails/jquery-ujs/wiki/ajax
https://github.com/jamesflorentino/nanoScrollerJS/pull/138
https://github.com/jamesflorentino/nanoScrollerJS/issues/152
http://railsware.com/blog/2012/05/21/shared-handlebars-templates-for-rails-3/
http://learnvimscriptthehardway.stevelosh.com/chapters/02.html
http://handlebarsjs.com




Решить вопрос с экстра плагинама к ckeditor. они не должны находиться в app. а в vendor/../ckeditor засунуть не получается. как вариант добавлять путь в javascript'e, либо найти другой вариант (возможно использовать другую директорию)




Тестовые данные в FIXTURES

MITSUBISHI	
  Galant
    3310-infiniti
    2008 - 2013, 9 поколение [2-й рестайлинг]
      3310-toyota
      CN седан 4-дв. 2....
        2102-nissan
  Lancer
    3310-infiniti
  Lancer Ralliart
    3310-toyota
    Lancer Ralliart (2008)
      3310-infiniti


TOYOTA
  Camry Hybrid

TOYOTA
  Celica Camry
    2102-nissan
    3310-infiniti
    3310-toyota

TOYOTA	
  Camry Gracia
    Camry Gracia (1996)
      2.2 л, бензин, 14...
        2102-kia

TOYOTA
  Camry
    Camry (XV10) (1991)
      Седан - 2.2 AT Ov...
        2102-kia
    Camry (XV50) (2011)	
      2.5 AT (181 л. с....
        3310-toyota
      2.0 AT (148 л. с....
        2102-kia
      2.0 AT (148 л. с....
    Camry (V10) (1982)
      3310-toyota




Временно вырезал сюда в связи с написанием более изящным способом без find_by_sql

    #sql = "
    #  WITH DEDUPE AS (
    #    SELECT sa.brand_id, sa.cached_brand, ROW_NUMBER() OVER (PARTITION BY sa.brand_id ORDER by sa.brand_id) AS OCCURENCE
    #    FROM spare_infos si
    #    JOIN spare_applicabilities sa ON si.id = sa.spare_info_id
    #    WHERE si.spare_catalog_id = ?
    #  )
    #  SELECT * FROM DEDUPE
    #  WHERE
    #  OCCURENCE = 1
    #".squish
    #@brands = SpareApplicability.find_by_sql([sql, params[:category_id].to_i])

    #sql = "
    #  WITH DEDUPE AS (
    #    SELECT sa.model_id, sa.cached_model, ROW_NUMBER() OVER (PARTITION BY sa.model_id ORDER by sa.model_id) AS OCCURENCE
    #    FROM spare_infos si
    #    JOIN spare_applicabilities sa ON si.id = sa.spare_info_id
    #    WHERE si.spare_catalog_id = :spare_catalog_id
    #      AND sa.brand_id = :brand_id
    #  )
    #  SELECT * FROM DEDUPE
    #  WHERE
    #  OCCURENCE = 1
    #".squish
    #@models = SpareApplicability.find_by_sql([sql, spare_catalog_id: params[:category_id].to_i, brand_id: params[:id].to_i])

    #sql = "
    #  WITH DEDUPE AS (
    #    SELECT sa.modification_id, sa.cached_modification, ROW_NUMBER() OVER (PARTITION BY sa.modification_id ORDER by sa.modification_id) AS OCCURENCE
    #    FROM spare_infos si
    #    JOIN spare_applicabilities sa ON si.id = sa.spare_info_id
    #    WHERE si.spare_catalog_id = :spare_catalog_id
    #      AND sa.generation_id = :generation_id
    #      AND sa.modification_id IS NOT NULL
    #  )
    #  SELECT * FROM DEDUPE
    #  WHERE
    #  OCCURENCE = 1
    #".squish
    #@modifications = SpareApplicability.find_by_sql([sql, spare_catalog_id: params[:category_id].to_i, generation_id: params[:id].to_i])

    #@parts = SpareInfo.joins(:spare_applicabilities).where(spare_catalog_id: params[:category_id].to_i)
    #@parts = @parts.where(spare_applicabilities: {generation_id: params[:id].to_i, modification_id: nil})


    #sql = "
    #  WITH DEDUPE AS (
    #    SELECT sa.generation_id, sa.cached_generation, ROW_NUMBER() OVER (PARTITION BY sa.generation_id ORDER by sa.generation_id) AS OCCURENCE
    #    FROM spare_infos si
    #    JOIN spare_applicabilities sa ON si.id = sa.spare_info_id
    #    WHERE si.spare_catalog_id = :spare_catalog_id
    #      AND sa.model_id = :model_id
    #      AND sa.generation_id IS NOT NULL
    #  )
    #  SELECT * FROM DEDUPE
    #  WHERE
    #  OCCURENCE = 1
    #".squish

    #@generations = SpareApplicability.find_by_sql([sql, spare_catalog_id: params[:category_id].to_i, model_id: params[:id].to_i])

    #@parts = SpareInfo.joins(:spare_applicabilities).where(spare_catalog_id: params[:category_id].to_i)
    #@parts = @parts.where(spare_applicabilities: {model_id: params[:id].to_i, generation_id: nil})



    #@parts = SpareInfo.joins(:spare_applicabilities).where(spare_catalog_id: params[:category_id].to_i)
    #@parts = @parts.where(spare_applicabilities: {modification_id: params[:id].to_i})



    #sql = "
    #WITH DEDUPE AS (
    #  SELECT spare_catalog_id, cached_spare_catalog, ROW_NUMBER() OVER ( PARTITION BY spare_catalog_id ORDER BY spare_catalog_id) AS OCCURENCE FROM spare_infos
    #)
    #SELECT * FROM DEDUPE
    #WHERE
    #OCCURENCE = 1".squish


    #@categories = SpareInfo.find_by_sql(sql)

    ---------------


    #has_many :spare_infos, ->(object){where(spare_applicabilities: {cached_modification: nil}).uniq}, through: :spare_applicabilities
    #has_many :spare_infos, ->(object){where(spare_applicabilities: {cached_generation: nil}).uniq}, through: :spare_applicabilities
    #has_many :spare_infos, ->(object){uniq}, through: :spare_applicabilities

    ---------------

    #get "/n/:category/", constraints: CategoriesConstraint.new, category: /.*/, to: "categories#show"
    #get "/n/:category/:brand", constraints: CategoriesConstraint.new, category: /.*/, brand: /.*/, to: "categories#show"
    #get "/n/:category/:brand/:model", constraints: CategoriesConstraint.new, category: /.*/, brand: /.*/, model: /.*/, to: "categories#show"
    #get "/n/:category/:brand/:model/:generation", constraints: CategoriesConstraint.new, category: /.*/, brand: /.*/, model: /.*/, generation: /.*/, to: "categories#show"
    #get "/n/:category/:brand/:model/:generation/:modification", constraints: CategoriesConstraint.new, category: /.*/, brand: /.*/, model: /.*/, generation: /.*/, modification: /.*/, to: "categories#show"



rails g migration AddFieldsToModifications grade:string body:integer power:integer fuel:integer transmission:integer doors:integer generation:string engine:string displacement:integer steering:integer

----------------

