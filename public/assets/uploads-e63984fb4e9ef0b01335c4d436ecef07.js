/*!
 * jQuery UI Widget 1.10.4+amd
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2014 jQuery Foundation and other contributors
 * Released under the MIT license.
 * http://jquery.org/license
 *
 * http://api.jqueryui.com/jQuery.widget/
 */
!function(factory) {
    "function" == typeof define && define.amd ? define([ "jquery" ], factory) :factory(jQuery);
}(function($, undefined) {
    var uuid = 0, slice = Array.prototype.slice, _cleanData = $.cleanData;
    $.cleanData = function(elems) {
        for (var elem, i = 0; null != (elem = elems[i]); i++) try {
            $(elem).triggerHandler("remove");
        } catch (e) {}
        _cleanData(elems);
    }, $.widget = function(name, base, prototype) {
        var fullName, existingConstructor, constructor, basePrototype, proxiedPrototype = {}, namespace = name.split(".")[0];
        name = name.split(".")[1], fullName = namespace + "-" + name, prototype || (prototype = base, 
        base = $.Widget), $.expr[":"][fullName.toLowerCase()] = function(elem) {
            return !!$.data(elem, fullName);
        }, $[namespace] = $[namespace] || {}, existingConstructor = $[namespace][name], 
        constructor = $[namespace][name] = function(options, element) {
            return this._createWidget ? void (arguments.length && this._createWidget(options, element)) :new constructor(options, element);
        }, $.extend(constructor, existingConstructor, {
            version:prototype.version,
            _proto:$.extend({}, prototype),
            _childConstructors:[]
        }), basePrototype = new base(), basePrototype.options = $.widget.extend({}, basePrototype.options), 
        $.each(prototype, function(prop, value) {
            return $.isFunction(value) ? void (proxiedPrototype[prop] = function() {
                var _super = function() {
                    return base.prototype[prop].apply(this, arguments);
                }, _superApply = function(args) {
                    return base.prototype[prop].apply(this, args);
                };
                return function() {
                    var returnValue, __super = this._super, __superApply = this._superApply;
                    return this._super = _super, this._superApply = _superApply, returnValue = value.apply(this, arguments), 
                    this._super = __super, this._superApply = __superApply, returnValue;
                };
            }()) :void (proxiedPrototype[prop] = value);
        }), constructor.prototype = $.widget.extend(basePrototype, {
            widgetEventPrefix:existingConstructor ? basePrototype.widgetEventPrefix || name :name
        }, proxiedPrototype, {
            constructor:constructor,
            namespace:namespace,
            widgetName:name,
            widgetFullName:fullName
        }), existingConstructor ? ($.each(existingConstructor._childConstructors, function(i, child) {
            var childPrototype = child.prototype;
            $.widget(childPrototype.namespace + "." + childPrototype.widgetName, constructor, child._proto);
        }), delete existingConstructor._childConstructors) :base._childConstructors.push(constructor), 
        $.widget.bridge(name, constructor);
    }, $.widget.extend = function(target) {
        for (var key, value, input = slice.call(arguments, 1), inputIndex = 0, inputLength = input.length; inputLength > inputIndex; inputIndex++) for (key in input[inputIndex]) value = input[inputIndex][key], 
        input[inputIndex].hasOwnProperty(key) && value !== undefined && (target[key] = $.isPlainObject(value) ? $.isPlainObject(target[key]) ? $.widget.extend({}, target[key], value) :$.widget.extend({}, value) :value);
        return target;
    }, $.widget.bridge = function(name, object) {
        var fullName = object.prototype.widgetFullName || name;
        $.fn[name] = function(options) {
            var isMethodCall = "string" == typeof options, args = slice.call(arguments, 1), returnValue = this;
            return options = !isMethodCall && args.length ? $.widget.extend.apply(null, [ options ].concat(args)) :options, 
            this.each(isMethodCall ? function() {
                var methodValue, instance = $.data(this, fullName);
                return instance ? $.isFunction(instance[options]) && "_" !== options.charAt(0) ? (methodValue = instance[options].apply(instance, args), 
                methodValue !== instance && methodValue !== undefined ? (returnValue = methodValue && methodValue.jquery ? returnValue.pushStack(methodValue.get()) :methodValue, 
                !1) :void 0) :$.error("no such method '" + options + "' for " + name + " widget instance") :$.error("cannot call methods on " + name + " prior to initialization; attempted to call method '" + options + "'");
            } :function() {
                var instance = $.data(this, fullName);
                instance ? instance.option(options || {})._init() :$.data(this, fullName, new object(options, this));
            }), returnValue;
        };
    }, $.Widget = function() {}, $.Widget._childConstructors = [], $.Widget.prototype = {
        widgetName:"widget",
        widgetEventPrefix:"",
        defaultElement:"<div>",
        options:{
            disabled:!1,
            create:null
        },
        _createWidget:function(options, element) {
            element = $(element || this.defaultElement || this)[0], this.element = $(element), 
            this.uuid = uuid++, this.eventNamespace = "." + this.widgetName + this.uuid, this.options = $.widget.extend({}, this.options, this._getCreateOptions(), options), 
            this.bindings = $(), this.hoverable = $(), this.focusable = $(), element !== this && ($.data(element, this.widgetFullName, this), 
            this._on(!0, this.element, {
                remove:function(event) {
                    event.target === element && this.destroy();
                }
            }), this.document = $(element.style ? element.ownerDocument :element.document || element), 
            this.window = $(this.document[0].defaultView || this.document[0].parentWindow)), 
            this._create(), this._trigger("create", null, this._getCreateEventData()), this._init();
        },
        _getCreateOptions:$.noop,
        _getCreateEventData:$.noop,
        _create:$.noop,
        _init:$.noop,
        destroy:function() {
            this._destroy(), this.element.unbind(this.eventNamespace).removeData(this.widgetName).removeData(this.widgetFullName).removeData($.camelCase(this.widgetFullName)), 
            this.widget().unbind(this.eventNamespace).removeAttr("aria-disabled").removeClass(this.widgetFullName + "-disabled ui-state-disabled"), 
            this.bindings.unbind(this.eventNamespace), this.hoverable.removeClass("ui-state-hover"), 
            this.focusable.removeClass("ui-state-focus");
        },
        _destroy:$.noop,
        widget:function() {
            return this.element;
        },
        option:function(key, value) {
            var parts, curOption, i, options = key;
            if (0 === arguments.length) return $.widget.extend({}, this.options);
            if ("string" == typeof key) if (options = {}, parts = key.split("."), key = parts.shift(), 
            parts.length) {
                for (curOption = options[key] = $.widget.extend({}, this.options[key]), i = 0; i < parts.length - 1; i++) curOption[parts[i]] = curOption[parts[i]] || {}, 
                curOption = curOption[parts[i]];
                if (key = parts.pop(), 1 === arguments.length) return curOption[key] === undefined ? null :curOption[key];
                curOption[key] = value;
            } else {
                if (1 === arguments.length) return this.options[key] === undefined ? null :this.options[key];
                options[key] = value;
            }
            return this._setOptions(options), this;
        },
        _setOptions:function(options) {
            var key;
            for (key in options) this._setOption(key, options[key]);
            return this;
        },
        _setOption:function(key, value) {
            return this.options[key] = value, "disabled" === key && (this.widget().toggleClass(this.widgetFullName + "-disabled ui-state-disabled", !!value).attr("aria-disabled", value), 
            this.hoverable.removeClass("ui-state-hover"), this.focusable.removeClass("ui-state-focus")), 
            this;
        },
        enable:function() {
            return this._setOption("disabled", !1);
        },
        disable:function() {
            return this._setOption("disabled", !0);
        },
        _on:function(suppressDisabledCheck, element, handlers) {
            var delegateElement, instance = this;
            "boolean" != typeof suppressDisabledCheck && (handlers = element, element = suppressDisabledCheck, 
            suppressDisabledCheck = !1), handlers ? (element = delegateElement = $(element), 
            this.bindings = this.bindings.add(element)) :(handlers = element, element = this.element, 
            delegateElement = this.widget()), $.each(handlers, function(event, handler) {
                function handlerProxy() {
                    return suppressDisabledCheck || instance.options.disabled !== !0 && !$(this).hasClass("ui-state-disabled") ? ("string" == typeof handler ? instance[handler] :handler).apply(instance, arguments) :void 0;
                }
                "string" != typeof handler && (handlerProxy.guid = handler.guid = handler.guid || handlerProxy.guid || $.guid++);
                var match = event.match(/^(\w+)\s*(.*)$/), eventName = match[1] + instance.eventNamespace, selector = match[2];
                selector ? delegateElement.delegate(selector, eventName, handlerProxy) :element.bind(eventName, handlerProxy);
            });
        },
        _off:function(element, eventName) {
            eventName = (eventName || "").split(" ").join(this.eventNamespace + " ") + this.eventNamespace, 
            element.unbind(eventName).undelegate(eventName);
        },
        _delay:function(handler, delay) {
            function handlerProxy() {
                return ("string" == typeof handler ? instance[handler] :handler).apply(instance, arguments);
            }
            var instance = this;
            return setTimeout(handlerProxy, delay || 0);
        },
        _hoverable:function(element) {
            this.hoverable = this.hoverable.add(element), this._on(element, {
                mouseenter:function(event) {
                    $(event.currentTarget).addClass("ui-state-hover");
                },
                mouseleave:function(event) {
                    $(event.currentTarget).removeClass("ui-state-hover");
                }
            });
        },
        _focusable:function(element) {
            this.focusable = this.focusable.add(element), this._on(element, {
                focusin:function(event) {
                    $(event.currentTarget).addClass("ui-state-focus");
                },
                focusout:function(event) {
                    $(event.currentTarget).removeClass("ui-state-focus");
                }
            });
        },
        _trigger:function(type, event, data) {
            var prop, orig, callback = this.options[type];
            if (data = data || {}, event = $.Event(event), event.type = (type === this.widgetEventPrefix ? type :this.widgetEventPrefix + type).toLowerCase(), 
            event.target = this.element[0], orig = event.originalEvent) for (prop in orig) prop in event || (event[prop] = orig[prop]);
            return this.element.trigger(event, data), !($.isFunction(callback) && callback.apply(this.element[0], [ event ].concat(data)) === !1 || event.isDefaultPrevented());
        }
    }, $.each({
        show:"fadeIn",
        hide:"fadeOut"
    }, function(method, defaultEffect) {
        $.Widget.prototype["_" + method] = function(element, options, callback) {
            "string" == typeof options && (options = {
                effect:options
            });
            var hasOptions, effectName = options ? options === !0 || "number" == typeof options ? defaultEffect :options.effect || defaultEffect :method;
            options = options || {}, "number" == typeof options && (options = {
                duration:options
            }), hasOptions = !$.isEmptyObject(options), options.complete = callback, options.delay && element.delay(options.delay), 
            hasOptions && $.effects && $.effects.effect[effectName] ? element[method](options) :effectName !== method && element[effectName] ? element[effectName](options.duration, options.easing, callback) :element.queue(function(next) {
                $(this)[method](), callback && callback.call(element[0]), next();
            });
        };
    });
}), /*
 * jQuery Iframe Transport Plugin 1.8.2
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2011, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
function(factory) {
    "use strict";
    "function" == typeof define && define.amd ? define([ "jquery" ], factory) :factory(window.jQuery);
}(function($) {
    "use strict";
    var counter = 0;
    $.ajaxTransport("iframe", function(options) {
        if (options.async) {
            var form, iframe, addParamChar, initialIframeSrc = options.initialIframeSrc || "javascript:false;";
            return {
                send:function(_, completeCallback) {
                    form = $('<form style="display:none;"></form>'), form.attr("accept-charset", options.formAcceptCharset), 
                    addParamChar = /\?/.test(options.url) ? "&" :"?", "DELETE" === options.type ? (options.url = options.url + addParamChar + "_method=DELETE", 
                    options.type = "POST") :"PUT" === options.type ? (options.url = options.url + addParamChar + "_method=PUT", 
                    options.type = "POST") :"PATCH" === options.type && (options.url = options.url + addParamChar + "_method=PATCH", 
                    options.type = "POST"), counter += 1, iframe = $('<iframe src="' + initialIframeSrc + '" name="iframe-transport-' + counter + '"></iframe>').bind("load", function() {
                        var fileInputClones, paramNames = $.isArray(options.paramName) ? options.paramName :[ options.paramName ];
                        iframe.unbind("load").bind("load", function() {
                            var response;
                            try {
                                if (response = iframe.contents(), !response.length || !response[0].firstChild) throw new Error();
                            } catch (e) {
                                response = void 0;
                            }
                            completeCallback(200, "success", {
                                iframe:response
                            }), $('<iframe src="' + initialIframeSrc + '"></iframe>').appendTo(form), window.setTimeout(function() {
                                form.remove();
                            }, 0);
                        }), form.prop("target", iframe.prop("name")).prop("action", options.url).prop("method", options.type), 
                        options.formData && $.each(options.formData, function(index, field) {
                            $('<input type="hidden"/>').prop("name", field.name).val(field.value).appendTo(form);
                        }), options.fileInput && options.fileInput.length && "POST" === options.type && (fileInputClones = options.fileInput.clone(), 
                        options.fileInput.after(function(index) {
                            return fileInputClones[index];
                        }), options.paramName && options.fileInput.each(function(index) {
                            $(this).prop("name", paramNames[index] || options.paramName);
                        }), form.append(options.fileInput).prop("enctype", "multipart/form-data").prop("encoding", "multipart/form-data"), 
                        options.fileInput.removeAttr("form")), form.submit(), fileInputClones && fileInputClones.length && options.fileInput.each(function(index, input) {
                            var clone = $(fileInputClones[index]);
                            $(input).prop("name", clone.prop("name")).attr("form", clone.attr("form")), clone.replaceWith(input);
                        });
                    }), form.append(iframe).appendTo(document.body);
                },
                abort:function() {
                    iframe && iframe.unbind("load").prop("src", initialIframeSrc), form && form.remove();
                }
            };
        }
    }), $.ajaxSetup({
        converters:{
            "iframe text":function(iframe) {
                return iframe && $(iframe[0].body).text();
            },
            "iframe json":function(iframe) {
                return iframe && $.parseJSON($(iframe[0].body).text());
            },
            "iframe html":function(iframe) {
                return iframe && $(iframe[0].body).html();
            },
            "iframe xml":function(iframe) {
                var xmlDoc = iframe && iframe[0];
                return xmlDoc && $.isXMLDoc(xmlDoc) ? xmlDoc :$.parseXML(xmlDoc.XMLDocument && xmlDoc.XMLDocument.xml || $(xmlDoc.body).html());
            },
            "iframe script":function(iframe) {
                return iframe && $.globalEval($(iframe[0].body).text());
            }
        }
    });
}), /*
 * jQuery File Upload Plugin 5.40.0
 * https://github.com/blueimp/jQuery-File-Upload
 *
 * Copyright 2010, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://www.opensource.org/licenses/MIT
 */
function(factory) {
    "use strict";
    "function" == typeof define && define.amd ? define([ "jquery", "jquery.ui.widget" ], factory) :factory(window.jQuery);
}(function($) {
    "use strict";
    $.support.fileInput = !(new RegExp("(Android (1\\.[0156]|2\\.[01]))|(Windows Phone (OS 7|8\\.0))|(XBLWP)|(ZuneWP)|(WPDesktop)|(w(eb)?OSBrowser)|(webOS)|(Kindle/(1\\.0|2\\.[05]|3\\.0))").test(window.navigator.userAgent) || $('<input type="file">').prop("disabled")), 
    $.support.xhrFileUpload = !(!window.ProgressEvent || !window.FileReader), $.support.xhrFormDataFileUpload = !!window.FormData, 
    $.support.blobSlice = window.Blob && (Blob.prototype.slice || Blob.prototype.webkitSlice || Blob.prototype.mozSlice), 
    $.widget("blueimp.fileupload", {
        options:{
            dropZone:$(document),
            pasteZone:$(document),
            fileInput:void 0,
            replaceFileInput:!0,
            paramName:void 0,
            singleFileUploads:!0,
            limitMultiFileUploads:void 0,
            limitMultiFileUploadSize:void 0,
            limitMultiFileUploadSizeOverhead:512,
            sequentialUploads:!1,
            limitConcurrentUploads:void 0,
            forceIframeTransport:!1,
            redirect:void 0,
            redirectParamName:void 0,
            postMessage:void 0,
            multipart:!0,
            maxChunkSize:void 0,
            uploadedBytes:void 0,
            recalculateProgress:!0,
            progressInterval:100,
            bitrateInterval:500,
            autoUpload:!0,
            messages:{
                uploadedBytes:"Uploaded bytes exceed file size"
            },
            i18n:function(message, context) {
                return message = this.messages[message] || message.toString(), context && $.each(context, function(key, value) {
                    message = message.replace("{" + key + "}", value);
                }), message;
            },
            formData:function(form) {
                return form.serializeArray();
            },
            add:function(e, data) {
                return e.isDefaultPrevented() ? !1 :void ((data.autoUpload || data.autoUpload !== !1 && $(this).fileupload("option", "autoUpload")) && data.process().done(function() {
                    data.submit();
                }));
            },
            processData:!1,
            contentType:!1,
            cache:!1
        },
        _specialOptions:[ "fileInput", "dropZone", "pasteZone", "multipart", "forceIframeTransport" ],
        _blobSlice:$.support.blobSlice && function() {
            var slice = this.slice || this.webkitSlice || this.mozSlice;
            return slice.apply(this, arguments);
        },
        _BitrateTimer:function() {
            this.timestamp = Date.now ? Date.now() :new Date().getTime(), this.loaded = 0, this.bitrate = 0, 
            this.getBitrate = function(now, loaded, interval) {
                var timeDiff = now - this.timestamp;
                return (!this.bitrate || !interval || timeDiff > interval) && (this.bitrate = (loaded - this.loaded) * (1e3 / timeDiff) * 8, 
                this.loaded = loaded, this.timestamp = now), this.bitrate;
            };
        },
        _isXHRUpload:function(options) {
            return !options.forceIframeTransport && (!options.multipart && $.support.xhrFileUpload || $.support.xhrFormDataFileUpload);
        },
        _getFormData:function(options) {
            var formData;
            return "function" === $.type(options.formData) ? options.formData(options.form) :$.isArray(options.formData) ? options.formData :"object" === $.type(options.formData) ? (formData = [], 
            $.each(options.formData, function(name, value) {
                formData.push({
                    name:name,
                    value:value
                });
            }), formData) :[];
        },
        _getTotal:function(files) {
            var total = 0;
            return $.each(files, function(index, file) {
                total += file.size || 1;
            }), total;
        },
        _initProgressObject:function(obj) {
            var progress = {
                loaded:0,
                total:0,
                bitrate:0
            };
            obj._progress ? $.extend(obj._progress, progress) :obj._progress = progress;
        },
        _initResponseObject:function(obj) {
            var prop;
            if (obj._response) for (prop in obj._response) obj._response.hasOwnProperty(prop) && delete obj._response[prop]; else obj._response = {};
        },
        _onProgress:function(e, data) {
            if (e.lengthComputable) {
                var loaded, now = Date.now ? Date.now() :new Date().getTime();
                if (data._time && data.progressInterval && now - data._time < data.progressInterval && e.loaded !== e.total) return;
                data._time = now, loaded = Math.floor(e.loaded / e.total * (data.chunkSize || data._progress.total)) + (data.uploadedBytes || 0), 
                this._progress.loaded += loaded - data._progress.loaded, this._progress.bitrate = this._bitrateTimer.getBitrate(now, this._progress.loaded, data.bitrateInterval), 
                data._progress.loaded = data.loaded = loaded, data._progress.bitrate = data.bitrate = data._bitrateTimer.getBitrate(now, loaded, data.bitrateInterval), 
                this._trigger("progress", $.Event("progress", {
                    delegatedEvent:e
                }), data), this._trigger("progressall", $.Event("progressall", {
                    delegatedEvent:e
                }), this._progress);
            }
        },
        _initProgressListener:function(options) {
            var that = this, xhr = options.xhr ? options.xhr() :$.ajaxSettings.xhr();
            xhr.upload && ($(xhr.upload).bind("progress", function(e) {
                var oe = e.originalEvent;
                e.lengthComputable = oe.lengthComputable, e.loaded = oe.loaded, e.total = oe.total, 
                that._onProgress(e, options);
            }), options.xhr = function() {
                return xhr;
            });
        },
        _isInstanceOf:function(type, obj) {
            return Object.prototype.toString.call(obj) === "[object " + type + "]";
        },
        _initXHRData:function(options) {
            var formData, that = this, file = options.files[0], multipart = options.multipart || !$.support.xhrFileUpload, paramName = "array" === $.type(options.paramName) ? options.paramName[0] :options.paramName;
            options.headers = $.extend({}, options.headers), options.contentRange && (options.headers["Content-Range"] = options.contentRange), 
            multipart && !options.blob && this._isInstanceOf("File", file) || (options.headers["Content-Disposition"] = 'attachment; filename="' + encodeURI(file.name) + '"'), 
            multipart ? $.support.xhrFormDataFileUpload && (options.postMessage ? (formData = this._getFormData(options), 
            options.blob ? formData.push({
                name:paramName,
                value:options.blob
            }) :$.each(options.files, function(index, file) {
                formData.push({
                    name:"array" === $.type(options.paramName) && options.paramName[index] || paramName,
                    value:file
                });
            })) :(that._isInstanceOf("FormData", options.formData) ? formData = options.formData :(formData = new FormData(), 
            $.each(this._getFormData(options), function(index, field) {
                formData.append(field.name, field.value);
            })), options.blob ? formData.append(paramName, options.blob, file.name) :$.each(options.files, function(index, file) {
                (that._isInstanceOf("File", file) || that._isInstanceOf("Blob", file)) && formData.append("array" === $.type(options.paramName) && options.paramName[index] || paramName, file, file.uploadName || file.name);
            })), options.data = formData) :(options.contentType = file.type || "application/octet-stream", 
            options.data = options.blob || file), options.blob = null;
        },
        _initIframeSettings:function(options) {
            var targetHost = $("<a></a>").prop("href", options.url).prop("host");
            options.dataType = "iframe " + (options.dataType || ""), options.formData = this._getFormData(options), 
            options.redirect && targetHost && targetHost !== location.host && options.formData.push({
                name:options.redirectParamName || "redirect",
                value:options.redirect
            });
        },
        _initDataSettings:function(options) {
            this._isXHRUpload(options) ? (this._chunkedUpload(options, !0) || (options.data || this._initXHRData(options), 
            this._initProgressListener(options)), options.postMessage && (options.dataType = "postmessage " + (options.dataType || ""))) :this._initIframeSettings(options);
        },
        _getParamName:function(options) {
            var fileInput = $(options.fileInput), paramName = options.paramName;
            return paramName ? $.isArray(paramName) || (paramName = [ paramName ]) :(paramName = [], 
            fileInput.each(function() {
                for (var input = $(this), name = input.prop("name") || "files[]", i = (input.prop("files") || [ 1 ]).length; i; ) paramName.push(name), 
                i -= 1;
            }), paramName.length || (paramName = [ fileInput.prop("name") || "files[]" ])), 
            paramName;
        },
        _initFormSettings:function(options) {
            options.form && options.form.length || (options.form = $(options.fileInput.prop("form")), 
            options.form.length || (options.form = $(this.options.fileInput.prop("form")))), 
            options.paramName = this._getParamName(options), options.url || (options.url = options.form.prop("action") || location.href), 
            options.type = (options.type || "string" === $.type(options.form.prop("method")) && options.form.prop("method") || "").toUpperCase(), 
            "POST" !== options.type && "PUT" !== options.type && "PATCH" !== options.type && (options.type = "POST"), 
            options.formAcceptCharset || (options.formAcceptCharset = options.form.attr("accept-charset"));
        },
        _getAJAXSettings:function(data) {
            var options = $.extend({}, this.options, data);
            return this._initFormSettings(options), this._initDataSettings(options), options;
        },
        _getDeferredState:function(deferred) {
            return deferred.state ? deferred.state() :deferred.isResolved() ? "resolved" :deferred.isRejected() ? "rejected" :"pending";
        },
        _enhancePromise:function(promise) {
            return promise.success = promise.done, promise.error = promise.fail, promise.complete = promise.always, 
            promise;
        },
        _getXHRPromise:function(resolveOrReject, context, args) {
            var dfd = $.Deferred(), promise = dfd.promise();
            return context = context || this.options.context || promise, resolveOrReject === !0 ? dfd.resolveWith(context, args) :resolveOrReject === !1 && dfd.rejectWith(context, args), 
            promise.abort = dfd.promise, this._enhancePromise(promise);
        },
        _addConvenienceMethods:function(e, data) {
            var that = this, getPromise = function(args) {
                return $.Deferred().resolveWith(that, args).promise();
            };
            data.process = function(resolveFunc, rejectFunc) {
                return (resolveFunc || rejectFunc) && (data._processQueue = this._processQueue = (this._processQueue || getPromise([ this ])).pipe(function() {
                    return data.errorThrown ? $.Deferred().rejectWith(that, [ data ]).promise() :getPromise(arguments);
                }).pipe(resolveFunc, rejectFunc)), this._processQueue || getPromise([ this ]);
            }, data.submit = function() {
                return "pending" !== this.state() && (data.jqXHR = this.jqXHR = that._trigger("submit", $.Event("submit", {
                    delegatedEvent:e
                }), this) !== !1 && that._onSend(e, this)), this.jqXHR || that._getXHRPromise();
            }, data.abort = function() {
                return this.jqXHR ? this.jqXHR.abort() :(this.errorThrown = "abort", that._trigger("fail", null, this), 
                that._getXHRPromise(!1));
            }, data.state = function() {
                return this.jqXHR ? that._getDeferredState(this.jqXHR) :this._processQueue ? that._getDeferredState(this._processQueue) :void 0;
            }, data.processing = function() {
                return !this.jqXHR && this._processQueue && "pending" === that._getDeferredState(this._processQueue);
            }, data.progress = function() {
                return this._progress;
            }, data.response = function() {
                return this._response;
            };
        },
        _getUploadedBytes:function(jqXHR) {
            var range = jqXHR.getResponseHeader("Range"), parts = range && range.split("-"), upperBytesPos = parts && parts.length > 1 && parseInt(parts[1], 10);
            return upperBytesPos && upperBytesPos + 1;
        },
        _chunkedUpload:function(options, testOnly) {
            options.uploadedBytes = options.uploadedBytes || 0;
            var jqXHR, upload, that = this, file = options.files[0], fs = file.size, ub = options.uploadedBytes, mcs = options.maxChunkSize || fs, slice = this._blobSlice, dfd = $.Deferred(), promise = dfd.promise();
            return this._isXHRUpload(options) && slice && (ub || fs > mcs) && !options.data ? testOnly ? !0 :ub >= fs ? (file.error = options.i18n("uploadedBytes"), 
            this._getXHRPromise(!1, options.context, [ null, "error", file.error ])) :(upload = function() {
                var o = $.extend({}, options), currentLoaded = o._progress.loaded;
                o.blob = slice.call(file, ub, ub + mcs, file.type), o.chunkSize = o.blob.size, o.contentRange = "bytes " + ub + "-" + (ub + o.chunkSize - 1) + "/" + fs, 
                that._initXHRData(o), that._initProgressListener(o), jqXHR = (that._trigger("chunksend", null, o) !== !1 && $.ajax(o) || that._getXHRPromise(!1, o.context)).done(function(result, textStatus, jqXHR) {
                    ub = that._getUploadedBytes(jqXHR) || ub + o.chunkSize, currentLoaded + o.chunkSize - o._progress.loaded && that._onProgress($.Event("progress", {
                        lengthComputable:!0,
                        loaded:ub - o.uploadedBytes,
                        total:ub - o.uploadedBytes
                    }), o), options.uploadedBytes = o.uploadedBytes = ub, o.result = result, o.textStatus = textStatus, 
                    o.jqXHR = jqXHR, that._trigger("chunkdone", null, o), that._trigger("chunkalways", null, o), 
                    fs > ub ? upload() :dfd.resolveWith(o.context, [ result, textStatus, jqXHR ]);
                }).fail(function(jqXHR, textStatus, errorThrown) {
                    o.jqXHR = jqXHR, o.textStatus = textStatus, o.errorThrown = errorThrown, that._trigger("chunkfail", null, o), 
                    that._trigger("chunkalways", null, o), dfd.rejectWith(o.context, [ jqXHR, textStatus, errorThrown ]);
                });
            }, this._enhancePromise(promise), promise.abort = function() {
                return jqXHR.abort();
            }, upload(), promise) :!1;
        },
        _beforeSend:function(e, data) {
            0 === this._active && (this._trigger("start"), this._bitrateTimer = new this._BitrateTimer(), 
            this._progress.loaded = this._progress.total = 0, this._progress.bitrate = 0), this._initResponseObject(data), 
            this._initProgressObject(data), data._progress.loaded = data.loaded = data.uploadedBytes || 0, 
            data._progress.total = data.total = this._getTotal(data.files) || 1, data._progress.bitrate = data.bitrate = 0, 
            this._active += 1, this._progress.loaded += data.loaded, this._progress.total += data.total;
        },
        _onDone:function(result, textStatus, jqXHR, options) {
            var total = options._progress.total, response = options._response;
            options._progress.loaded < total && this._onProgress($.Event("progress", {
                lengthComputable:!0,
                loaded:total,
                total:total
            }), options), response.result = options.result = result, response.textStatus = options.textStatus = textStatus, 
            response.jqXHR = options.jqXHR = jqXHR, this._trigger("done", null, options);
        },
        _onFail:function(jqXHR, textStatus, errorThrown, options) {
            var response = options._response;
            options.recalculateProgress && (this._progress.loaded -= options._progress.loaded, 
            this._progress.total -= options._progress.total), response.jqXHR = options.jqXHR = jqXHR, 
            response.textStatus = options.textStatus = textStatus, response.errorThrown = options.errorThrown = errorThrown, 
            this._trigger("fail", null, options);
        },
        _onAlways:function(jqXHRorResult, textStatus, jqXHRorError, options) {
            this._trigger("always", null, options);
        },
        _onSend:function(e, data) {
            data.submit || this._addConvenienceMethods(e, data);
            var jqXHR, aborted, slot, pipe, that = this, options = that._getAJAXSettings(data), send = function() {
                return that._sending += 1, options._bitrateTimer = new that._BitrateTimer(), jqXHR = jqXHR || ((aborted || that._trigger("send", $.Event("send", {
                    delegatedEvent:e
                }), options) === !1) && that._getXHRPromise(!1, options.context, aborted) || that._chunkedUpload(options) || $.ajax(options)).done(function(result, textStatus, jqXHR) {
                    that._onDone(result, textStatus, jqXHR, options);
                }).fail(function(jqXHR, textStatus, errorThrown) {
                    that._onFail(jqXHR, textStatus, errorThrown, options);
                }).always(function(jqXHRorResult, textStatus, jqXHRorError) {
                    if (that._onAlways(jqXHRorResult, textStatus, jqXHRorError, options), that._sending -= 1, 
                    that._active -= 1, options.limitConcurrentUploads && options.limitConcurrentUploads > that._sending) for (var nextSlot = that._slots.shift(); nextSlot; ) {
                        if ("pending" === that._getDeferredState(nextSlot)) {
                            nextSlot.resolve();
                            break;
                        }
                        nextSlot = that._slots.shift();
                    }
                    0 === that._active && that._trigger("stop");
                });
            };
            return this._beforeSend(e, options), this.options.sequentialUploads || this.options.limitConcurrentUploads && this.options.limitConcurrentUploads <= this._sending ? (this.options.limitConcurrentUploads > 1 ? (slot = $.Deferred(), 
            this._slots.push(slot), pipe = slot.pipe(send)) :(this._sequence = this._sequence.pipe(send, send), 
            pipe = this._sequence), pipe.abort = function() {
                return aborted = [ void 0, "abort", "abort" ], jqXHR ? jqXHR.abort() :(slot && slot.rejectWith(options.context, aborted), 
                send());
            }, this._enhancePromise(pipe)) :send();
        },
        _onAdd:function(e, data) {
            var paramNameSet, paramNameSlice, fileSet, i, that = this, result = !0, options = $.extend({}, this.options, data), files = data.files, filesLength = files.length, limit = options.limitMultiFileUploads, limitSize = options.limitMultiFileUploadSize, overhead = options.limitMultiFileUploadSizeOverhead, batchSize = 0, paramName = this._getParamName(options), j = 0;
            if (!limitSize || filesLength && void 0 !== files[0].size || (limitSize = void 0), 
            (options.singleFileUploads || limit || limitSize) && this._isXHRUpload(options)) if (options.singleFileUploads || limitSize || !limit) if (!options.singleFileUploads && limitSize) for (fileSet = [], 
            paramNameSet = [], i = 0; filesLength > i; i += 1) batchSize += files[i].size + overhead, 
            (i + 1 === filesLength || batchSize + files[i + 1].size + overhead > limitSize || limit && i + 1 - j >= limit) && (fileSet.push(files.slice(j, i + 1)), 
            paramNameSlice = paramName.slice(j, i + 1), paramNameSlice.length || (paramNameSlice = paramName), 
            paramNameSet.push(paramNameSlice), j = i + 1, batchSize = 0); else paramNameSet = paramName; else for (fileSet = [], 
            paramNameSet = [], i = 0; filesLength > i; i += limit) fileSet.push(files.slice(i, i + limit)), 
            paramNameSlice = paramName.slice(i, i + limit), paramNameSlice.length || (paramNameSlice = paramName), 
            paramNameSet.push(paramNameSlice); else fileSet = [ files ], paramNameSet = [ paramName ];
            return data.originalFiles = files, $.each(fileSet || files, function(index, element) {
                var newData = $.extend({}, data);
                return newData.files = fileSet ? element :[ element ], newData.paramName = paramNameSet[index], 
                that._initResponseObject(newData), that._initProgressObject(newData), that._addConvenienceMethods(e, newData), 
                result = that._trigger("add", $.Event("add", {
                    delegatedEvent:e
                }), newData);
            }), result;
        },
        _replaceFileInput:function(input) {
            var inputClone = input.clone(!0);
            $("<form></form>").append(inputClone)[0].reset(), input.after(inputClone).detach(), 
            $.cleanData(input.unbind("remove")), this.options.fileInput = this.options.fileInput.map(function(i, el) {
                return el === input[0] ? inputClone[0] :el;
            }), input[0] === this.element[0] && (this.element = inputClone);
        },
        _handleFileTreeEntry:function(entry, path) {
            var dirReader, that = this, dfd = $.Deferred(), errorHandler = function(e) {
                e && !e.entry && (e.entry = entry), dfd.resolve([ e ]);
            };
            return path = path || "", entry.isFile ? entry._file ? (entry._file.relativePath = path, 
            dfd.resolve(entry._file)) :entry.file(function(file) {
                file.relativePath = path, dfd.resolve(file);
            }, errorHandler) :entry.isDirectory ? (dirReader = entry.createReader(), dirReader.readEntries(function(entries) {
                that._handleFileTreeEntries(entries, path + entry.name + "/").done(function(files) {
                    dfd.resolve(files);
                }).fail(errorHandler);
            }, errorHandler)) :dfd.resolve([]), dfd.promise();
        },
        _handleFileTreeEntries:function(entries, path) {
            var that = this;
            return $.when.apply($, $.map(entries, function(entry) {
                return that._handleFileTreeEntry(entry, path);
            })).pipe(function() {
                return Array.prototype.concat.apply([], arguments);
            });
        },
        _getDroppedFiles:function(dataTransfer) {
            dataTransfer = dataTransfer || {};
            var items = dataTransfer.items;
            return items && items.length && (items[0].webkitGetAsEntry || items[0].getAsEntry) ? this._handleFileTreeEntries($.map(items, function(item) {
                var entry;
                return item.webkitGetAsEntry ? (entry = item.webkitGetAsEntry(), entry && (entry._file = item.getAsFile()), 
                entry) :item.getAsEntry();
            })) :$.Deferred().resolve($.makeArray(dataTransfer.files)).promise();
        },
        _getSingleFileInputFiles:function(fileInput) {
            fileInput = $(fileInput);
            var files, value, entries = fileInput.prop("webkitEntries") || fileInput.prop("entries");
            if (entries && entries.length) return this._handleFileTreeEntries(entries);
            if (files = $.makeArray(fileInput.prop("files")), files.length) void 0 === files[0].name && files[0].fileName && $.each(files, function(index, file) {
                file.name = file.fileName, file.size = file.fileSize;
            }); else {
                if (value = fileInput.prop("value"), !value) return $.Deferred().resolve([]).promise();
                files = [ {
                    name:value.replace(/^.*\\/, "")
                } ];
            }
            return $.Deferred().resolve(files).promise();
        },
        _getFileInputFiles:function(fileInput) {
            return fileInput instanceof $ && 1 !== fileInput.length ? $.when.apply($, $.map(fileInput, this._getSingleFileInputFiles)).pipe(function() {
                return Array.prototype.concat.apply([], arguments);
            }) :this._getSingleFileInputFiles(fileInput);
        },
        _onChange:function(e) {
            var that = this, data = {
                fileInput:$(e.target),
                form:$(e.target.form)
            };
            this._getFileInputFiles(data.fileInput).always(function(files) {
                data.files = files, that.options.replaceFileInput && that._replaceFileInput(data.fileInput), 
                that._trigger("change", $.Event("change", {
                    delegatedEvent:e
                }), data) !== !1 && that._onAdd(e, data);
            });
        },
        _onPaste:function(e) {
            var items = e.originalEvent && e.originalEvent.clipboardData && e.originalEvent.clipboardData.items, data = {
                files:[]
            };
            items && items.length && ($.each(items, function(index, item) {
                var file = item.getAsFile && item.getAsFile();
                file && data.files.push(file);
            }), this._trigger("paste", $.Event("paste", {
                delegatedEvent:e
            }), data) !== !1 && this._onAdd(e, data));
        },
        _onDrop:function(e) {
            e.dataTransfer = e.originalEvent && e.originalEvent.dataTransfer;
            var that = this, dataTransfer = e.dataTransfer, data = {};
            dataTransfer && dataTransfer.files && dataTransfer.files.length && (e.preventDefault(), 
            this._getDroppedFiles(dataTransfer).always(function(files) {
                data.files = files, that._trigger("drop", $.Event("drop", {
                    delegatedEvent:e
                }), data) !== !1 && that._onAdd(e, data);
            }));
        },
        _onDragOver:function(e) {
            e.dataTransfer = e.originalEvent && e.originalEvent.dataTransfer;
            var dataTransfer = e.dataTransfer;
            dataTransfer && -1 !== $.inArray("Files", dataTransfer.types) && this._trigger("dragover", $.Event("dragover", {
                delegatedEvent:e
            })) !== !1 && (e.preventDefault(), dataTransfer.dropEffect = "copy");
        },
        _initEventHandlers:function() {
            this._isXHRUpload(this.options) && (this._on(this.options.dropZone, {
                dragover:this._onDragOver,
                drop:this._onDrop
            }), this._on(this.options.pasteZone, {
                paste:this._onPaste
            })), $.support.fileInput && this._on(this.options.fileInput, {
                change:this._onChange
            });
        },
        _destroyEventHandlers:function() {
            this._off(this.options.dropZone, "dragover drop"), this._off(this.options.pasteZone, "paste"), 
            this._off(this.options.fileInput, "change");
        },
        _setOption:function(key, value) {
            var reinit = -1 !== $.inArray(key, this._specialOptions);
            reinit && this._destroyEventHandlers(), this._super(key, value), reinit && (this._initSpecialOptions(), 
            this._initEventHandlers());
        },
        _initSpecialOptions:function() {
            var options = this.options;
            void 0 === options.fileInput ? options.fileInput = this.element.is('input[type="file"]') ? this.element :this.element.find('input[type="file"]') :options.fileInput instanceof $ || (options.fileInput = $(options.fileInput)), 
            options.dropZone instanceof $ || (options.dropZone = $(options.dropZone)), options.pasteZone instanceof $ || (options.pasteZone = $(options.pasteZone));
        },
        _getRegExp:function(str) {
            var parts = str.split("/"), modifiers = parts.pop();
            return parts.shift(), new RegExp(parts.join("/"), modifiers);
        },
        _isRegExpOption:function(key, value) {
            return "url" !== key && "string" === $.type(value) && /^\/.*\/[igm]{0,3}$/.test(value);
        },
        _initDataAttributes:function() {
            var that = this, options = this.options;
            $.each($(this.element[0].cloneNode(!1)).data(), function(key, value) {
                that._isRegExpOption(key, value) && (value = that._getRegExp(value)), options[key] = value;
            });
        },
        _create:function() {
            this._initDataAttributes(), this._initSpecialOptions(), this._slots = [], this._sequence = this._getXHRPromise(!0), 
            this._sending = this._active = 0, this._initProgressObject(this), this._initEventHandlers();
        },
        active:function() {
            return this._active;
        },
        progress:function() {
            return this._progress;
        },
        add:function(data) {
            var that = this;
            data && !this.options.disabled && (data.fileInput && !data.files ? this._getFileInputFiles(data.fileInput).always(function(files) {
                data.files = files, that._onAdd(null, data);
            }) :(data.files = $.makeArray(data.files), this._onAdd(null, data)));
        },
        send:function(data) {
            if (data && !this.options.disabled) {
                if (data.fileInput && !data.files) {
                    var jqXHR, aborted, that = this, dfd = $.Deferred(), promise = dfd.promise();
                    return promise.abort = function() {
                        return aborted = !0, jqXHR ? jqXHR.abort() :(dfd.reject(null, "abort", "abort"), 
                        promise);
                    }, this._getFileInputFiles(data.fileInput).always(function(files) {
                        if (!aborted) {
                            if (!files.length) return void dfd.reject();
                            data.files = files, jqXHR = that._onSend(null, data).then(function(result, textStatus, jqXHR) {
                                dfd.resolve(result, textStatus, jqXHR);
                            }, function(jqXHR, textStatus, errorThrown) {
                                dfd.reject(jqXHR, textStatus, errorThrown);
                            });
                        }
                    }), this._enhancePromise(promise);
                }
                if (data.files = $.makeArray(data.files), data.files.length) return this._onSend(null, data);
            }
            return this._getXHRPromise(!1, data && data.context);
        }
    });
}), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, $(document).on("click", ".image-process", function(event) {
        var image_process;
        return event.preventDefault(), image_process = window.open($(this).attr("href"), "image_process", "scrollbars=yes, resizable=yes, width=500, height=500");
    }), $(document).on("click", "#insert_files_into_ckeditor", function() {
        var editor, text;
        return text = $(".upload").map(function(i, element) {
            return $(element).html();
        }), text = "<p>" + text.get().join("</p><p>") + "</p><p></p>", editor = $("#ckeditor-name").text(), 
        window.opener.CKEDITOR.instances[editor].insertHtml(text), window.close();
    }), App.init_jquery_file_upload = function() {
        "use strict";
        return $(".fileupload").fileupload({
            url:"/uploads",
            dataType:"json",
            done:function(e, data) {
                var uploads;
                return uploads = $(e.target).closest("[rel='uploads-parent']").find(".uploads"), 
                $.each(data.result.files, function(index, upload) {
                    var crop, file, name, remove, rotate;
                    return file = "", rotate = "", crop = "", remove = "", name = "<small>" + upload.name + "</small>", 
                    upload.image ? (file = "<span class='upload'> <a class='image-process' href='" + upload.url + "'>" + name + "<br/> <img src='" + upload.thumbnail_url + "'></a> </span> ", 
                    rotate = '<a class="image-process btn btn-default btn-xs" href="' + upload.rotate_url + '"> <i class="fa fa-rotate-right"></i></a> ', 
                    crop = '<a class="image-process btn btn-default btn-xs" href="' + upload.crop_url + '"> <i class="fa fa-crop"></i></a> ') :file = '<span class="upload"> <a class="image-process" href="' + upload.url + '">' + name + "</a> </span>", 
                    remove = '<a class="btn btn-default btn-xs" href="#"> <i class="fa fa-times"></i></a> ', 
                    $("<p class='pull-left well well-sm' style='margin: 5px; background: #FFF'/>").html(file + '<div class="btn-group-vertical">' + rotate + crop + remove + "</div>").appendTo(uploads);
                });
            },
            start:function() {
                return $("#insert_files_into_ckeditor").hide();
            },
            progressall:function() {
                return $("#insert_files_into_ckeditor").show();
            }
        }), $(".fileupload").fileupload("option", {
            paramName:"upload[upload]"
        });
    }, $(function() {
        return App.init_jquery_file_upload();
    });
}.call(this);