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

AFFIX
http://jsfiddle.net/s54va/
http://stackoverflow.com/questions/12070970/how-to-use-the-new-affix-plugin-in-twitters-bootstrap-2-1-0
http://jsfiddle.net/NRhv8/13/
http://jsfiddle.net/namuol/Uaa3U/


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
