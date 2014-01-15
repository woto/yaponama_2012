App = exports ? this

App.resident_template = _.template """
  <div class="well well-sm bottom-space-sm concrete-seller">
    <div class="media" style="margin: 0; position: relative">
      <a class="pull-left" href="#">
        <img class="media-object" src="/assets/no_avatar.png" style="width: 48px; height: 48px" ></img>
      </a>
      <div class="media-body muted">

        <button class="btn btn-xs btn-default pull-right"  <%= obj.online ? '' : 'disabled="disabled"'  %> rel="tooltip" data-placement="left" title="Разрабатывается">
          <i class="fa fa-phone"></i>
          Позвонить
          <br />
          <small>
            <%= obj.phone %>
          </small>
        </button>

        <h4 class="bottom-space-xs">
          <a href="#" id="select-addressee-<%= obj.id %>" class="select-addressee dashed" data-id="<%= obj.id %>"><%= obj.surname %> <%= obj.name %> <%= obj.patronymic %></a>
        </h4>

        <h6 style="margin: 0; line-height: 12px">

          <%= _.compact([obj.place, obj.post]).join('; ') %>

          <% if(obj.online) { %>
            <span class="label label-success">Онлайн</span>
          <% } else { %>
            <span class="label label-default">Оффлайн</span>
          <% } %>

        </h6>

      </div>
    </div>
  </div>
"""
