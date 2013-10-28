        when *['catalog_number']
          if item.class == Product
            if item.hide_catalog_number
              res = "".html_safe
              if admin_zone?
                res << h(val)
              end
              res << " " << icon('asterisk text-muted')
            else
              val
            end
          end
