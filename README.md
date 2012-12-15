Yaponama 2012
=============

Перевод в статус отказ с различных статусов
----------------------

<table>
    <tr>
        <td>Статус (англ.)</td>
        <td>В работе покуп.</td>
        <td>Счет покуп.</td>
        <td>В работе пост.</td>
        <td>Счет пост.</td>
    </tr>
    <tr>
        <td>incart</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <td>inorder</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <td>ordered</td>
        <td>-</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <td>pre_supplier</td>
        <td>-</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <td>post_supplier</td>
        <td>-</td>
        <td>0</td>
        <td>-</td>
        <td>0</td>
    </tr>
    <tr>
        <td>stock</td>
        <td>-</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
    <tr>
        <td>complete</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
        <td>0</td>
    </tr>
</table>

Влияние изменения закупочной, продажной цен и количества позиций на сумму в работе у поставщика или покупателя
-
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

- 0 Означает, что изменение этого поля никак не влияет на долг.
- Y Означает возможность изменения этого поля и влечет за собой изменение долга.
- N Означает отсутствие возможности изменения этого поля.
--
Первое значение - сумма, второе - количество

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
