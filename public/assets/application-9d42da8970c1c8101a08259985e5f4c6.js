/*!
 * jQuery JavaScript Library v1.11.0
 * http://jquery.com/
 *
 * Includes Sizzle.js
 * http://sizzlejs.com/
 *
 * Copyright 2005, 2014 jQuery Foundation, Inc. and other contributors
 * Released under the MIT license
 * http://jquery.org/license
 *
 * Date: 2014-01-23T21:02Z
 */
function Player() {}

function Song() {}

/*!
 * Bootstrap v3.1.0 (http://getbootstrap.com)
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 */
if (function(global, factory) {
    "object" == typeof module && "object" == typeof module.exports ? module.exports = global.document ? factory(global, !0) :function(w) {
        if (!w.document) throw new Error("jQuery requires a window with a document");
        return factory(w);
    } :factory(global);
}("undefined" != typeof window ? window :this, function(window, noGlobal) {
    function isArraylike(obj) {
        var length = obj.length, type = jQuery.type(obj);
        return "function" === type || jQuery.isWindow(obj) ? !1 :1 === obj.nodeType && length ? !0 :"array" === type || 0 === length || "number" == typeof length && length > 0 && length - 1 in obj;
    }
    function winnow(elements, qualifier, not) {
        if (jQuery.isFunction(qualifier)) return jQuery.grep(elements, function(elem, i) {
            return !!qualifier.call(elem, i, elem) !== not;
        });
        if (qualifier.nodeType) return jQuery.grep(elements, function(elem) {
            return elem === qualifier !== not;
        });
        if ("string" == typeof qualifier) {
            if (risSimple.test(qualifier)) return jQuery.filter(qualifier, elements, not);
            qualifier = jQuery.filter(qualifier, elements);
        }
        return jQuery.grep(elements, function(elem) {
            return jQuery.inArray(elem, qualifier) >= 0 !== not;
        });
    }
    function sibling(cur, dir) {
        do cur = cur[dir]; while (cur && 1 !== cur.nodeType);
        return cur;
    }
    function createOptions(options) {
        var object = optionsCache[options] = {};
        return jQuery.each(options.match(rnotwhite) || [], function(_, flag) {
            object[flag] = !0;
        }), object;
    }
    function detach() {
        document.addEventListener ? (document.removeEventListener("DOMContentLoaded", completed, !1), 
        window.removeEventListener("load", completed, !1)) :(document.detachEvent("onreadystatechange", completed), 
        window.detachEvent("onload", completed));
    }
    function completed() {
        (document.addEventListener || "load" === event.type || "complete" === document.readyState) && (detach(), 
        jQuery.ready());
    }
    function dataAttr(elem, key, data) {
        if (void 0 === data && 1 === elem.nodeType) {
            var name = "data-" + key.replace(rmultiDash, "-$1").toLowerCase();
            if (data = elem.getAttribute(name), "string" == typeof data) {
                try {
                    data = "true" === data ? !0 :"false" === data ? !1 :"null" === data ? null :+data + "" === data ? +data :rbrace.test(data) ? jQuery.parseJSON(data) :data;
                } catch (e) {}
                jQuery.data(elem, key, data);
            } else data = void 0;
        }
        return data;
    }
    function isEmptyDataObject(obj) {
        var name;
        for (name in obj) if (("data" !== name || !jQuery.isEmptyObject(obj[name])) && "toJSON" !== name) return !1;
        return !0;
    }
    function internalData(elem, name, data, pvt) {
        if (jQuery.acceptData(elem)) {
            var ret, thisCache, internalKey = jQuery.expando, isNode = elem.nodeType, cache = isNode ? jQuery.cache :elem, id = isNode ? elem[internalKey] :elem[internalKey] && internalKey;
            if (id && cache[id] && (pvt || cache[id].data) || void 0 !== data || "string" != typeof name) return id || (id = isNode ? elem[internalKey] = deletedIds.pop() || jQuery.guid++ :internalKey), 
            cache[id] || (cache[id] = isNode ? {} :{
                toJSON:jQuery.noop
            }), ("object" == typeof name || "function" == typeof name) && (pvt ? cache[id] = jQuery.extend(cache[id], name) :cache[id].data = jQuery.extend(cache[id].data, name)), 
            thisCache = cache[id], pvt || (thisCache.data || (thisCache.data = {}), thisCache = thisCache.data), 
            void 0 !== data && (thisCache[jQuery.camelCase(name)] = data), "string" == typeof name ? (ret = thisCache[name], 
            null == ret && (ret = thisCache[jQuery.camelCase(name)])) :ret = thisCache, ret;
        }
    }
    function internalRemoveData(elem, name, pvt) {
        if (jQuery.acceptData(elem)) {
            var thisCache, i, isNode = elem.nodeType, cache = isNode ? jQuery.cache :elem, id = isNode ? elem[jQuery.expando] :jQuery.expando;
            if (cache[id]) {
                if (name && (thisCache = pvt ? cache[id] :cache[id].data)) {
                    jQuery.isArray(name) ? name = name.concat(jQuery.map(name, jQuery.camelCase)) :name in thisCache ? name = [ name ] :(name = jQuery.camelCase(name), 
                    name = name in thisCache ? [ name ] :name.split(" ")), i = name.length;
                    for (;i--; ) delete thisCache[name[i]];
                    if (pvt ? !isEmptyDataObject(thisCache) :!jQuery.isEmptyObject(thisCache)) return;
                }
                (pvt || (delete cache[id].data, isEmptyDataObject(cache[id]))) && (isNode ? jQuery.cleanData([ elem ], !0) :support.deleteExpando || cache != cache.window ? delete cache[id] :cache[id] = null);
            }
        }
    }
    function returnTrue() {
        return !0;
    }
    function returnFalse() {
        return !1;
    }
    function safeActiveElement() {
        try {
            return document.activeElement;
        } catch (err) {}
    }
    function createSafeFragment(document) {
        var list = nodeNames.split("|"), safeFrag = document.createDocumentFragment();
        if (safeFrag.createElement) for (;list.length; ) safeFrag.createElement(list.pop());
        return safeFrag;
    }
    function getAll(context, tag) {
        var elems, elem, i = 0, found = typeof context.getElementsByTagName !== strundefined ? context.getElementsByTagName(tag || "*") :typeof context.querySelectorAll !== strundefined ? context.querySelectorAll(tag || "*") :void 0;
        if (!found) for (found = [], elems = context.childNodes || context; null != (elem = elems[i]); i++) !tag || jQuery.nodeName(elem, tag) ? found.push(elem) :jQuery.merge(found, getAll(elem, tag));
        return void 0 === tag || tag && jQuery.nodeName(context, tag) ? jQuery.merge([ context ], found) :found;
    }
    function fixDefaultChecked(elem) {
        rcheckableType.test(elem.type) && (elem.defaultChecked = elem.checked);
    }
    function manipulationTarget(elem, content) {
        return jQuery.nodeName(elem, "table") && jQuery.nodeName(11 !== content.nodeType ? content :content.firstChild, "tr") ? elem.getElementsByTagName("tbody")[0] || elem.appendChild(elem.ownerDocument.createElement("tbody")) :elem;
    }
    function disableScript(elem) {
        return elem.type = (null !== jQuery.find.attr(elem, "type")) + "/" + elem.type, 
        elem;
    }
    function restoreScript(elem) {
        var match = rscriptTypeMasked.exec(elem.type);
        return match ? elem.type = match[1] :elem.removeAttribute("type"), elem;
    }
    function setGlobalEval(elems, refElements) {
        for (var elem, i = 0; null != (elem = elems[i]); i++) jQuery._data(elem, "globalEval", !refElements || jQuery._data(refElements[i], "globalEval"));
    }
    function cloneCopyEvent(src, dest) {
        if (1 === dest.nodeType && jQuery.hasData(src)) {
            var type, i, l, oldData = jQuery._data(src), curData = jQuery._data(dest, oldData), events = oldData.events;
            if (events) {
                delete curData.handle, curData.events = {};
                for (type in events) for (i = 0, l = events[type].length; l > i; i++) jQuery.event.add(dest, type, events[type][i]);
            }
            curData.data && (curData.data = jQuery.extend({}, curData.data));
        }
    }
    function fixCloneNodeIssues(src, dest) {
        var nodeName, e, data;
        if (1 === dest.nodeType) {
            if (nodeName = dest.nodeName.toLowerCase(), !support.noCloneEvent && dest[jQuery.expando]) {
                data = jQuery._data(dest);
                for (e in data.events) jQuery.removeEvent(dest, e, data.handle);
                dest.removeAttribute(jQuery.expando);
            }
            "script" === nodeName && dest.text !== src.text ? (disableScript(dest).text = src.text, 
            restoreScript(dest)) :"object" === nodeName ? (dest.parentNode && (dest.outerHTML = src.outerHTML), 
            support.html5Clone && src.innerHTML && !jQuery.trim(dest.innerHTML) && (dest.innerHTML = src.innerHTML)) :"input" === nodeName && rcheckableType.test(src.type) ? (dest.defaultChecked = dest.checked = src.checked, 
            dest.value !== src.value && (dest.value = src.value)) :"option" === nodeName ? dest.defaultSelected = dest.selected = src.defaultSelected :("input" === nodeName || "textarea" === nodeName) && (dest.defaultValue = src.defaultValue);
        }
    }
    function actualDisplay(name, doc) {
        var elem = jQuery(doc.createElement(name)).appendTo(doc.body), display = window.getDefaultComputedStyle ? window.getDefaultComputedStyle(elem[0]).display :jQuery.css(elem[0], "display");
        return elem.detach(), display;
    }
    function defaultDisplay(nodeName) {
        var doc = document, display = elemdisplay[nodeName];
        return display || (display = actualDisplay(nodeName, doc), "none" !== display && display || (iframe = (iframe || jQuery("<iframe frameborder='0' width='0' height='0'/>")).appendTo(doc.documentElement), 
        doc = (iframe[0].contentWindow || iframe[0].contentDocument).document, doc.write(), 
        doc.close(), display = actualDisplay(nodeName, doc), iframe.detach()), elemdisplay[nodeName] = display), 
        display;
    }
    function addGetHookIf(conditionFn, hookFn) {
        return {
            get:function() {
                var condition = conditionFn();
                if (null != condition) return condition ? void delete this.get :(this.get = hookFn).apply(this, arguments);
            }
        };
    }
    function vendorPropName(style, name) {
        if (name in style) return name;
        for (var capName = name.charAt(0).toUpperCase() + name.slice(1), origName = name, i = cssPrefixes.length; i--; ) if (name = cssPrefixes[i] + capName, 
        name in style) return name;
        return origName;
    }
    function showHide(elements, show) {
        for (var display, elem, hidden, values = [], index = 0, length = elements.length; length > index; index++) elem = elements[index], 
        elem.style && (values[index] = jQuery._data(elem, "olddisplay"), display = elem.style.display, 
        show ? (values[index] || "none" !== display || (elem.style.display = ""), "" === elem.style.display && isHidden(elem) && (values[index] = jQuery._data(elem, "olddisplay", defaultDisplay(elem.nodeName)))) :values[index] || (hidden = isHidden(elem), 
        (display && "none" !== display || !hidden) && jQuery._data(elem, "olddisplay", hidden ? display :jQuery.css(elem, "display"))));
        for (index = 0; length > index; index++) elem = elements[index], elem.style && (show && "none" !== elem.style.display && "" !== elem.style.display || (elem.style.display = show ? values[index] || "" :"none"));
        return elements;
    }
    function setPositiveNumber(elem, value, subtract) {
        var matches = rnumsplit.exec(value);
        return matches ? Math.max(0, matches[1] - (subtract || 0)) + (matches[2] || "px") :value;
    }
    function augmentWidthOrHeight(elem, name, extra, isBorderBox, styles) {
        for (var i = extra === (isBorderBox ? "border" :"content") ? 4 :"width" === name ? 1 :0, val = 0; 4 > i; i += 2) "margin" === extra && (val += jQuery.css(elem, extra + cssExpand[i], !0, styles)), 
        isBorderBox ? ("content" === extra && (val -= jQuery.css(elem, "padding" + cssExpand[i], !0, styles)), 
        "margin" !== extra && (val -= jQuery.css(elem, "border" + cssExpand[i] + "Width", !0, styles))) :(val += jQuery.css(elem, "padding" + cssExpand[i], !0, styles), 
        "padding" !== extra && (val += jQuery.css(elem, "border" + cssExpand[i] + "Width", !0, styles)));
        return val;
    }
    function getWidthOrHeight(elem, name, extra) {
        var valueIsBorderBox = !0, val = "width" === name ? elem.offsetWidth :elem.offsetHeight, styles = getStyles(elem), isBorderBox = support.boxSizing() && "border-box" === jQuery.css(elem, "boxSizing", !1, styles);
        if (0 >= val || null == val) {
            if (val = curCSS(elem, name, styles), (0 > val || null == val) && (val = elem.style[name]), 
            rnumnonpx.test(val)) return val;
            valueIsBorderBox = isBorderBox && (support.boxSizingReliable() || val === elem.style[name]), 
            val = parseFloat(val) || 0;
        }
        return val + augmentWidthOrHeight(elem, name, extra || (isBorderBox ? "border" :"content"), valueIsBorderBox, styles) + "px";
    }
    function Tween(elem, options, prop, end, easing) {
        return new Tween.prototype.init(elem, options, prop, end, easing);
    }
    function createFxNow() {
        return setTimeout(function() {
            fxNow = void 0;
        }), fxNow = jQuery.now();
    }
    function genFx(type, includeWidth) {
        var which, attrs = {
            height:type
        }, i = 0;
        for (includeWidth = includeWidth ? 1 :0; 4 > i; i += 2 - includeWidth) which = cssExpand[i], 
        attrs["margin" + which] = attrs["padding" + which] = type;
        return includeWidth && (attrs.opacity = attrs.width = type), attrs;
    }
    function createTween(value, prop, animation) {
        for (var tween, collection = (tweeners[prop] || []).concat(tweeners["*"]), index = 0, length = collection.length; length > index; index++) if (tween = collection[index].call(animation, prop, value)) return tween;
    }
    function defaultPrefilter(elem, props, opts) {
        var prop, value, toggle, tween, hooks, oldfire, display, dDisplay, anim = this, orig = {}, style = elem.style, hidden = elem.nodeType && isHidden(elem), dataShow = jQuery._data(elem, "fxshow");
        opts.queue || (hooks = jQuery._queueHooks(elem, "fx"), null == hooks.unqueued && (hooks.unqueued = 0, 
        oldfire = hooks.empty.fire, hooks.empty.fire = function() {
            hooks.unqueued || oldfire();
        }), hooks.unqueued++, anim.always(function() {
            anim.always(function() {
                hooks.unqueued--, jQuery.queue(elem, "fx").length || hooks.empty.fire();
            });
        })), 1 === elem.nodeType && ("height" in props || "width" in props) && (opts.overflow = [ style.overflow, style.overflowX, style.overflowY ], 
        display = jQuery.css(elem, "display"), dDisplay = defaultDisplay(elem.nodeName), 
        "none" === display && (display = dDisplay), "inline" === display && "none" === jQuery.css(elem, "float") && (support.inlineBlockNeedsLayout && "inline" !== dDisplay ? style.zoom = 1 :style.display = "inline-block")), 
        opts.overflow && (style.overflow = "hidden", support.shrinkWrapBlocks() || anim.always(function() {
            style.overflow = opts.overflow[0], style.overflowX = opts.overflow[1], style.overflowY = opts.overflow[2];
        }));
        for (prop in props) if (value = props[prop], rfxtypes.exec(value)) {
            if (delete props[prop], toggle = toggle || "toggle" === value, value === (hidden ? "hide" :"show")) {
                if ("show" !== value || !dataShow || void 0 === dataShow[prop]) continue;
                hidden = !0;
            }
            orig[prop] = dataShow && dataShow[prop] || jQuery.style(elem, prop);
        }
        if (!jQuery.isEmptyObject(orig)) {
            dataShow ? "hidden" in dataShow && (hidden = dataShow.hidden) :dataShow = jQuery._data(elem, "fxshow", {}), 
            toggle && (dataShow.hidden = !hidden), hidden ? jQuery(elem).show() :anim.done(function() {
                jQuery(elem).hide();
            }), anim.done(function() {
                var prop;
                jQuery._removeData(elem, "fxshow");
                for (prop in orig) jQuery.style(elem, prop, orig[prop]);
            });
            for (prop in orig) tween = createTween(hidden ? dataShow[prop] :0, prop, anim), 
            prop in dataShow || (dataShow[prop] = tween.start, hidden && (tween.end = tween.start, 
            tween.start = "width" === prop || "height" === prop ? 1 :0));
        }
    }
    function propFilter(props, specialEasing) {
        var index, name, easing, value, hooks;
        for (index in props) if (name = jQuery.camelCase(index), easing = specialEasing[name], 
        value = props[index], jQuery.isArray(value) && (easing = value[1], value = props[index] = value[0]), 
        index !== name && (props[name] = value, delete props[index]), hooks = jQuery.cssHooks[name], 
        hooks && "expand" in hooks) {
            value = hooks.expand(value), delete props[name];
            for (index in value) index in props || (props[index] = value[index], specialEasing[index] = easing);
        } else specialEasing[name] = easing;
    }
    function Animation(elem, properties, options) {
        var result, stopped, index = 0, length = animationPrefilters.length, deferred = jQuery.Deferred().always(function() {
            delete tick.elem;
        }), tick = function() {
            if (stopped) return !1;
            for (var currentTime = fxNow || createFxNow(), remaining = Math.max(0, animation.startTime + animation.duration - currentTime), temp = remaining / animation.duration || 0, percent = 1 - temp, index = 0, length = animation.tweens.length; length > index; index++) animation.tweens[index].run(percent);
            return deferred.notifyWith(elem, [ animation, percent, remaining ]), 1 > percent && length ? remaining :(deferred.resolveWith(elem, [ animation ]), 
            !1);
        }, animation = deferred.promise({
            elem:elem,
            props:jQuery.extend({}, properties),
            opts:jQuery.extend(!0, {
                specialEasing:{}
            }, options),
            originalProperties:properties,
            originalOptions:options,
            startTime:fxNow || createFxNow(),
            duration:options.duration,
            tweens:[],
            createTween:function(prop, end) {
                var tween = jQuery.Tween(elem, animation.opts, prop, end, animation.opts.specialEasing[prop] || animation.opts.easing);
                return animation.tweens.push(tween), tween;
            },
            stop:function(gotoEnd) {
                var index = 0, length = gotoEnd ? animation.tweens.length :0;
                if (stopped) return this;
                for (stopped = !0; length > index; index++) animation.tweens[index].run(1);
                return gotoEnd ? deferred.resolveWith(elem, [ animation, gotoEnd ]) :deferred.rejectWith(elem, [ animation, gotoEnd ]), 
                this;
            }
        }), props = animation.props;
        for (propFilter(props, animation.opts.specialEasing); length > index; index++) if (result = animationPrefilters[index].call(animation, elem, props, animation.opts)) return result;
        return jQuery.map(props, createTween, animation), jQuery.isFunction(animation.opts.start) && animation.opts.start.call(elem, animation), 
        jQuery.fx.timer(jQuery.extend(tick, {
            elem:elem,
            anim:animation,
            queue:animation.opts.queue
        })), animation.progress(animation.opts.progress).done(animation.opts.done, animation.opts.complete).fail(animation.opts.fail).always(animation.opts.always);
    }
    function addToPrefiltersOrTransports(structure) {
        return function(dataTypeExpression, func) {
            "string" != typeof dataTypeExpression && (func = dataTypeExpression, dataTypeExpression = "*");
            var dataType, i = 0, dataTypes = dataTypeExpression.toLowerCase().match(rnotwhite) || [];
            if (jQuery.isFunction(func)) for (;dataType = dataTypes[i++]; ) "+" === dataType.charAt(0) ? (dataType = dataType.slice(1) || "*", 
            (structure[dataType] = structure[dataType] || []).unshift(func)) :(structure[dataType] = structure[dataType] || []).push(func);
        };
    }
    function inspectPrefiltersOrTransports(structure, options, originalOptions, jqXHR) {
        function inspect(dataType) {
            var selected;
            return inspected[dataType] = !0, jQuery.each(structure[dataType] || [], function(_, prefilterOrFactory) {
                var dataTypeOrTransport = prefilterOrFactory(options, originalOptions, jqXHR);
                return "string" != typeof dataTypeOrTransport || seekingTransport || inspected[dataTypeOrTransport] ? seekingTransport ? !(selected = dataTypeOrTransport) :void 0 :(options.dataTypes.unshift(dataTypeOrTransport), 
                inspect(dataTypeOrTransport), !1);
            }), selected;
        }
        var inspected = {}, seekingTransport = structure === transports;
        return inspect(options.dataTypes[0]) || !inspected["*"] && inspect("*");
    }
    function ajaxExtend(target, src) {
        var deep, key, flatOptions = jQuery.ajaxSettings.flatOptions || {};
        for (key in src) void 0 !== src[key] && ((flatOptions[key] ? target :deep || (deep = {}))[key] = src[key]);
        return deep && jQuery.extend(!0, target, deep), target;
    }
    function ajaxHandleResponses(s, jqXHR, responses) {
        for (var firstDataType, ct, finalDataType, type, contents = s.contents, dataTypes = s.dataTypes; "*" === dataTypes[0]; ) dataTypes.shift(), 
        void 0 === ct && (ct = s.mimeType || jqXHR.getResponseHeader("Content-Type"));
        if (ct) for (type in contents) if (contents[type] && contents[type].test(ct)) {
            dataTypes.unshift(type);
            break;
        }
        if (dataTypes[0] in responses) finalDataType = dataTypes[0]; else {
            for (type in responses) {
                if (!dataTypes[0] || s.converters[type + " " + dataTypes[0]]) {
                    finalDataType = type;
                    break;
                }
                firstDataType || (firstDataType = type);
            }
            finalDataType = finalDataType || firstDataType;
        }
        return finalDataType ? (finalDataType !== dataTypes[0] && dataTypes.unshift(finalDataType), 
        responses[finalDataType]) :void 0;
    }
    function ajaxConvert(s, response, jqXHR, isSuccess) {
        var conv2, current, conv, tmp, prev, converters = {}, dataTypes = s.dataTypes.slice();
        if (dataTypes[1]) for (conv in s.converters) converters[conv.toLowerCase()] = s.converters[conv];
        for (current = dataTypes.shift(); current; ) if (s.responseFields[current] && (jqXHR[s.responseFields[current]] = response), 
        !prev && isSuccess && s.dataFilter && (response = s.dataFilter(response, s.dataType)), 
        prev = current, current = dataTypes.shift()) if ("*" === current) current = prev; else if ("*" !== prev && prev !== current) {
            if (conv = converters[prev + " " + current] || converters["* " + current], !conv) for (conv2 in converters) if (tmp = conv2.split(" "), 
            tmp[1] === current && (conv = converters[prev + " " + tmp[0]] || converters["* " + tmp[0]])) {
                conv === !0 ? conv = converters[conv2] :converters[conv2] !== !0 && (current = tmp[0], 
                dataTypes.unshift(tmp[1]));
                break;
            }
            if (conv !== !0) if (conv && s["throws"]) response = conv(response); else try {
                response = conv(response);
            } catch (e) {
                return {
                    state:"parsererror",
                    error:conv ? e :"No conversion from " + prev + " to " + current
                };
            }
        }
        return {
            state:"success",
            data:response
        };
    }
    function buildParams(prefix, obj, traditional, add) {
        var name;
        if (jQuery.isArray(obj)) jQuery.each(obj, function(i, v) {
            traditional || rbracket.test(prefix) ? add(prefix, v) :buildParams(prefix + "[" + ("object" == typeof v ? i :"") + "]", v, traditional, add);
        }); else if (traditional || "object" !== jQuery.type(obj)) add(prefix, obj); else for (name in obj) buildParams(prefix + "[" + name + "]", obj[name], traditional, add);
    }
    function createStandardXHR() {
        try {
            return new window.XMLHttpRequest();
        } catch (e) {}
    }
    function createActiveXHR() {
        try {
            return new window.ActiveXObject("Microsoft.XMLHTTP");
        } catch (e) {}
    }
    function getWindow(elem) {
        return jQuery.isWindow(elem) ? elem :9 === elem.nodeType ? elem.defaultView || elem.parentWindow :!1;
    }
    var deletedIds = [], slice = deletedIds.slice, concat = deletedIds.concat, push = deletedIds.push, indexOf = deletedIds.indexOf, class2type = {}, toString = class2type.toString, hasOwn = class2type.hasOwnProperty, trim = "".trim, support = {}, version = "1.11.0", jQuery = function(selector, context) {
        return new jQuery.fn.init(selector, context);
    }, rtrim = /^[\s\uFEFF\xA0]+|[\s\uFEFF\xA0]+$/g, rmsPrefix = /^-ms-/, rdashAlpha = /-([\da-z])/gi, fcamelCase = function(all, letter) {
        return letter.toUpperCase();
    };
    jQuery.fn = jQuery.prototype = {
        jquery:version,
        constructor:jQuery,
        selector:"",
        length:0,
        toArray:function() {
            return slice.call(this);
        },
        get:function(num) {
            return null != num ? 0 > num ? this[num + this.length] :this[num] :slice.call(this);
        },
        pushStack:function(elems) {
            var ret = jQuery.merge(this.constructor(), elems);
            return ret.prevObject = this, ret.context = this.context, ret;
        },
        each:function(callback, args) {
            return jQuery.each(this, callback, args);
        },
        map:function(callback) {
            return this.pushStack(jQuery.map(this, function(elem, i) {
                return callback.call(elem, i, elem);
            }));
        },
        slice:function() {
            return this.pushStack(slice.apply(this, arguments));
        },
        first:function() {
            return this.eq(0);
        },
        last:function() {
            return this.eq(-1);
        },
        eq:function(i) {
            var len = this.length, j = +i + (0 > i ? len :0);
            return this.pushStack(j >= 0 && len > j ? [ this[j] ] :[]);
        },
        end:function() {
            return this.prevObject || this.constructor(null);
        },
        push:push,
        sort:deletedIds.sort,
        splice:deletedIds.splice
    }, jQuery.extend = jQuery.fn.extend = function() {
        var src, copyIsArray, copy, name, options, clone, target = arguments[0] || {}, i = 1, length = arguments.length, deep = !1;
        for ("boolean" == typeof target && (deep = target, target = arguments[i] || {}, 
        i++), "object" == typeof target || jQuery.isFunction(target) || (target = {}), i === length && (target = this, 
        i--); length > i; i++) if (null != (options = arguments[i])) for (name in options) src = target[name], 
        copy = options[name], target !== copy && (deep && copy && (jQuery.isPlainObject(copy) || (copyIsArray = jQuery.isArray(copy))) ? (copyIsArray ? (copyIsArray = !1, 
        clone = src && jQuery.isArray(src) ? src :[]) :clone = src && jQuery.isPlainObject(src) ? src :{}, 
        target[name] = jQuery.extend(deep, clone, copy)) :void 0 !== copy && (target[name] = copy));
        return target;
    }, jQuery.extend({
        expando:"jQuery" + (version + Math.random()).replace(/\D/g, ""),
        isReady:!0,
        error:function(msg) {
            throw new Error(msg);
        },
        noop:function() {},
        isFunction:function(obj) {
            return "function" === jQuery.type(obj);
        },
        isArray:Array.isArray || function(obj) {
            return "array" === jQuery.type(obj);
        },
        isWindow:function(obj) {
            return null != obj && obj == obj.window;
        },
        isNumeric:function(obj) {
            return obj - parseFloat(obj) >= 0;
        },
        isEmptyObject:function(obj) {
            var name;
            for (name in obj) return !1;
            return !0;
        },
        isPlainObject:function(obj) {
            var key;
            if (!obj || "object" !== jQuery.type(obj) || obj.nodeType || jQuery.isWindow(obj)) return !1;
            try {
                if (obj.constructor && !hasOwn.call(obj, "constructor") && !hasOwn.call(obj.constructor.prototype, "isPrototypeOf")) return !1;
            } catch (e) {
                return !1;
            }
            if (support.ownLast) for (key in obj) return hasOwn.call(obj, key);
            for (key in obj) ;
            return void 0 === key || hasOwn.call(obj, key);
        },
        type:function(obj) {
            return null == obj ? obj + "" :"object" == typeof obj || "function" == typeof obj ? class2type[toString.call(obj)] || "object" :typeof obj;
        },
        globalEval:function(data) {
            data && jQuery.trim(data) && (window.execScript || function(data) {
                window.eval.call(window, data);
            })(data);
        },
        camelCase:function(string) {
            return string.replace(rmsPrefix, "ms-").replace(rdashAlpha, fcamelCase);
        },
        nodeName:function(elem, name) {
            return elem.nodeName && elem.nodeName.toLowerCase() === name.toLowerCase();
        },
        each:function(obj, callback, args) {
            var value, i = 0, length = obj.length, isArray = isArraylike(obj);
            if (args) {
                if (isArray) for (;length > i && (value = callback.apply(obj[i], args), value !== !1); i++) ; else for (i in obj) if (value = callback.apply(obj[i], args), 
                value === !1) break;
            } else if (isArray) for (;length > i && (value = callback.call(obj[i], i, obj[i]), 
            value !== !1); i++) ; else for (i in obj) if (value = callback.call(obj[i], i, obj[i]), 
            value === !1) break;
            return obj;
        },
        trim:trim && !trim.call("﻿ ") ? function(text) {
            return null == text ? "" :trim.call(text);
        } :function(text) {
            return null == text ? "" :(text + "").replace(rtrim, "");
        },
        makeArray:function(arr, results) {
            var ret = results || [];
            return null != arr && (isArraylike(Object(arr)) ? jQuery.merge(ret, "string" == typeof arr ? [ arr ] :arr) :push.call(ret, arr)), 
            ret;
        },
        inArray:function(elem, arr, i) {
            var len;
            if (arr) {
                if (indexOf) return indexOf.call(arr, elem, i);
                for (len = arr.length, i = i ? 0 > i ? Math.max(0, len + i) :i :0; len > i; i++) if (i in arr && arr[i] === elem) return i;
            }
            return -1;
        },
        merge:function(first, second) {
            for (var len = +second.length, j = 0, i = first.length; len > j; ) first[i++] = second[j++];
            if (len !== len) for (;void 0 !== second[j]; ) first[i++] = second[j++];
            return first.length = i, first;
        },
        grep:function(elems, callback, invert) {
            for (var callbackInverse, matches = [], i = 0, length = elems.length, callbackExpect = !invert; length > i; i++) callbackInverse = !callback(elems[i], i), 
            callbackInverse !== callbackExpect && matches.push(elems[i]);
            return matches;
        },
        map:function(elems, callback, arg) {
            var value, i = 0, length = elems.length, isArray = isArraylike(elems), ret = [];
            if (isArray) for (;length > i; i++) value = callback(elems[i], i, arg), null != value && ret.push(value); else for (i in elems) value = callback(elems[i], i, arg), 
            null != value && ret.push(value);
            return concat.apply([], ret);
        },
        guid:1,
        proxy:function(fn, context) {
            var args, proxy, tmp;
            return "string" == typeof context && (tmp = fn[context], context = fn, fn = tmp), 
            jQuery.isFunction(fn) ? (args = slice.call(arguments, 2), proxy = function() {
                return fn.apply(context || this, args.concat(slice.call(arguments)));
            }, proxy.guid = fn.guid = fn.guid || jQuery.guid++, proxy) :void 0;
        },
        now:function() {
            return +new Date();
        },
        support:support
    }), jQuery.each("Boolean Number String Function Array Date RegExp Object Error".split(" "), function(i, name) {
        class2type["[object " + name + "]"] = name.toLowerCase();
    });
    var Sizzle = /*!
 * Sizzle CSS Selector Engine v1.10.16
 * http://sizzlejs.com/
 *
 * Copyright 2013 jQuery Foundation, Inc. and other contributors
 * Released under the MIT license
 * http://jquery.org/license
 *
 * Date: 2014-01-13
 */
    function(window) {
        function Sizzle(selector, context, results, seed) {
            var match, elem, m, nodeType, i, groups, old, nid, newContext, newSelector;
            if ((context ? context.ownerDocument || context :preferredDoc) !== document && setDocument(context), 
            context = context || document, results = results || [], !selector || "string" != typeof selector) return results;
            if (1 !== (nodeType = context.nodeType) && 9 !== nodeType) return [];
            if (documentIsHTML && !seed) {
                if (match = rquickExpr.exec(selector)) if (m = match[1]) {
                    if (9 === nodeType) {
                        if (elem = context.getElementById(m), !elem || !elem.parentNode) return results;
                        if (elem.id === m) return results.push(elem), results;
                    } else if (context.ownerDocument && (elem = context.ownerDocument.getElementById(m)) && contains(context, elem) && elem.id === m) return results.push(elem), 
                    results;
                } else {
                    if (match[2]) return push.apply(results, context.getElementsByTagName(selector)), 
                    results;
                    if ((m = match[3]) && support.getElementsByClassName && context.getElementsByClassName) return push.apply(results, context.getElementsByClassName(m)), 
                    results;
                }
                if (support.qsa && (!rbuggyQSA || !rbuggyQSA.test(selector))) {
                    if (nid = old = expando, newContext = context, newSelector = 9 === nodeType && selector, 
                    1 === nodeType && "object" !== context.nodeName.toLowerCase()) {
                        for (groups = tokenize(selector), (old = context.getAttribute("id")) ? nid = old.replace(rescape, "\\$&") :context.setAttribute("id", nid), 
                        nid = "[id='" + nid + "'] ", i = groups.length; i--; ) groups[i] = nid + toSelector(groups[i]);
                        newContext = rsibling.test(selector) && testContext(context.parentNode) || context, 
                        newSelector = groups.join(",");
                    }
                    if (newSelector) try {
                        return push.apply(results, newContext.querySelectorAll(newSelector)), results;
                    } catch (qsaError) {} finally {
                        old || context.removeAttribute("id");
                    }
                }
            }
            return select(selector.replace(rtrim, "$1"), context, results, seed);
        }
        function createCache() {
            function cache(key, value) {
                return keys.push(key + " ") > Expr.cacheLength && delete cache[keys.shift()], cache[key + " "] = value;
            }
            var keys = [];
            return cache;
        }
        function markFunction(fn) {
            return fn[expando] = !0, fn;
        }
        function assert(fn) {
            var div = document.createElement("div");
            try {
                return !!fn(div);
            } catch (e) {
                return !1;
            } finally {
                div.parentNode && div.parentNode.removeChild(div), div = null;
            }
        }
        function addHandle(attrs, handler) {
            for (var arr = attrs.split("|"), i = attrs.length; i--; ) Expr.attrHandle[arr[i]] = handler;
        }
        function siblingCheck(a, b) {
            var cur = b && a, diff = cur && 1 === a.nodeType && 1 === b.nodeType && (~b.sourceIndex || MAX_NEGATIVE) - (~a.sourceIndex || MAX_NEGATIVE);
            if (diff) return diff;
            if (cur) for (;cur = cur.nextSibling; ) if (cur === b) return -1;
            return a ? 1 :-1;
        }
        function createInputPseudo(type) {
            return function(elem) {
                var name = elem.nodeName.toLowerCase();
                return "input" === name && elem.type === type;
            };
        }
        function createButtonPseudo(type) {
            return function(elem) {
                var name = elem.nodeName.toLowerCase();
                return ("input" === name || "button" === name) && elem.type === type;
            };
        }
        function createPositionalPseudo(fn) {
            return markFunction(function(argument) {
                return argument = +argument, markFunction(function(seed, matches) {
                    for (var j, matchIndexes = fn([], seed.length, argument), i = matchIndexes.length; i--; ) seed[j = matchIndexes[i]] && (seed[j] = !(matches[j] = seed[j]));
                });
            });
        }
        function testContext(context) {
            return context && typeof context.getElementsByTagName !== strundefined && context;
        }
        function setFilters() {}
        function tokenize(selector, parseOnly) {
            var matched, match, tokens, type, soFar, groups, preFilters, cached = tokenCache[selector + " "];
            if (cached) return parseOnly ? 0 :cached.slice(0);
            for (soFar = selector, groups = [], preFilters = Expr.preFilter; soFar; ) {
                (!matched || (match = rcomma.exec(soFar))) && (match && (soFar = soFar.slice(match[0].length) || soFar), 
                groups.push(tokens = [])), matched = !1, (match = rcombinators.exec(soFar)) && (matched = match.shift(), 
                tokens.push({
                    value:matched,
                    type:match[0].replace(rtrim, " ")
                }), soFar = soFar.slice(matched.length));
                for (type in Expr.filter) !(match = matchExpr[type].exec(soFar)) || preFilters[type] && !(match = preFilters[type](match)) || (matched = match.shift(), 
                tokens.push({
                    value:matched,
                    type:type,
                    matches:match
                }), soFar = soFar.slice(matched.length));
                if (!matched) break;
            }
            return parseOnly ? soFar.length :soFar ? Sizzle.error(selector) :tokenCache(selector, groups).slice(0);
        }
        function toSelector(tokens) {
            for (var i = 0, len = tokens.length, selector = ""; len > i; i++) selector += tokens[i].value;
            return selector;
        }
        function addCombinator(matcher, combinator, base) {
            var dir = combinator.dir, checkNonElements = base && "parentNode" === dir, doneName = done++;
            return combinator.first ? function(elem, context, xml) {
                for (;elem = elem[dir]; ) if (1 === elem.nodeType || checkNonElements) return matcher(elem, context, xml);
            } :function(elem, context, xml) {
                var oldCache, outerCache, newCache = [ dirruns, doneName ];
                if (xml) {
                    for (;elem = elem[dir]; ) if ((1 === elem.nodeType || checkNonElements) && matcher(elem, context, xml)) return !0;
                } else for (;elem = elem[dir]; ) if (1 === elem.nodeType || checkNonElements) {
                    if (outerCache = elem[expando] || (elem[expando] = {}), (oldCache = outerCache[dir]) && oldCache[0] === dirruns && oldCache[1] === doneName) return newCache[2] = oldCache[2];
                    if (outerCache[dir] = newCache, newCache[2] = matcher(elem, context, xml)) return !0;
                }
            };
        }
        function elementMatcher(matchers) {
            return matchers.length > 1 ? function(elem, context, xml) {
                for (var i = matchers.length; i--; ) if (!matchers[i](elem, context, xml)) return !1;
                return !0;
            } :matchers[0];
        }
        function condense(unmatched, map, filter, context, xml) {
            for (var elem, newUnmatched = [], i = 0, len = unmatched.length, mapped = null != map; len > i; i++) (elem = unmatched[i]) && (!filter || filter(elem, context, xml)) && (newUnmatched.push(elem), 
            mapped && map.push(i));
            return newUnmatched;
        }
        function setMatcher(preFilter, selector, matcher, postFilter, postFinder, postSelector) {
            return postFilter && !postFilter[expando] && (postFilter = setMatcher(postFilter)), 
            postFinder && !postFinder[expando] && (postFinder = setMatcher(postFinder, postSelector)), 
            markFunction(function(seed, results, context, xml) {
                var temp, i, elem, preMap = [], postMap = [], preexisting = results.length, elems = seed || multipleContexts(selector || "*", context.nodeType ? [ context ] :context, []), matcherIn = !preFilter || !seed && selector ? elems :condense(elems, preMap, preFilter, context, xml), matcherOut = matcher ? postFinder || (seed ? preFilter :preexisting || postFilter) ? [] :results :matcherIn;
                if (matcher && matcher(matcherIn, matcherOut, context, xml), postFilter) for (temp = condense(matcherOut, postMap), 
                postFilter(temp, [], context, xml), i = temp.length; i--; ) (elem = temp[i]) && (matcherOut[postMap[i]] = !(matcherIn[postMap[i]] = elem));
                if (seed) {
                    if (postFinder || preFilter) {
                        if (postFinder) {
                            for (temp = [], i = matcherOut.length; i--; ) (elem = matcherOut[i]) && temp.push(matcherIn[i] = elem);
                            postFinder(null, matcherOut = [], temp, xml);
                        }
                        for (i = matcherOut.length; i--; ) (elem = matcherOut[i]) && (temp = postFinder ? indexOf.call(seed, elem) :preMap[i]) > -1 && (seed[temp] = !(results[temp] = elem));
                    }
                } else matcherOut = condense(matcherOut === results ? matcherOut.splice(preexisting, matcherOut.length) :matcherOut), 
                postFinder ? postFinder(null, results, matcherOut, xml) :push.apply(results, matcherOut);
            });
        }
        function matcherFromTokens(tokens) {
            for (var checkContext, matcher, j, len = tokens.length, leadingRelative = Expr.relative[tokens[0].type], implicitRelative = leadingRelative || Expr.relative[" "], i = leadingRelative ? 1 :0, matchContext = addCombinator(function(elem) {
                return elem === checkContext;
            }, implicitRelative, !0), matchAnyContext = addCombinator(function(elem) {
                return indexOf.call(checkContext, elem) > -1;
            }, implicitRelative, !0), matchers = [ function(elem, context, xml) {
                return !leadingRelative && (xml || context !== outermostContext) || ((checkContext = context).nodeType ? matchContext(elem, context, xml) :matchAnyContext(elem, context, xml));
            } ]; len > i; i++) if (matcher = Expr.relative[tokens[i].type]) matchers = [ addCombinator(elementMatcher(matchers), matcher) ]; else {
                if (matcher = Expr.filter[tokens[i].type].apply(null, tokens[i].matches), matcher[expando]) {
                    for (j = ++i; len > j && !Expr.relative[tokens[j].type]; j++) ;
                    return setMatcher(i > 1 && elementMatcher(matchers), i > 1 && toSelector(tokens.slice(0, i - 1).concat({
                        value:" " === tokens[i - 2].type ? "*" :""
                    })).replace(rtrim, "$1"), matcher, j > i && matcherFromTokens(tokens.slice(i, j)), len > j && matcherFromTokens(tokens = tokens.slice(j)), len > j && toSelector(tokens));
                }
                matchers.push(matcher);
            }
            return elementMatcher(matchers);
        }
        function matcherFromGroupMatchers(elementMatchers, setMatchers) {
            var bySet = setMatchers.length > 0, byElement = elementMatchers.length > 0, superMatcher = function(seed, context, xml, results, outermost) {
                var elem, j, matcher, matchedCount = 0, i = "0", unmatched = seed && [], setMatched = [], contextBackup = outermostContext, elems = seed || byElement && Expr.find.TAG("*", outermost), dirrunsUnique = dirruns += null == contextBackup ? 1 :Math.random() || .1, len = elems.length;
                for (outermost && (outermostContext = context !== document && context); i !== len && null != (elem = elems[i]); i++) {
                    if (byElement && elem) {
                        for (j = 0; matcher = elementMatchers[j++]; ) if (matcher(elem, context, xml)) {
                            results.push(elem);
                            break;
                        }
                        outermost && (dirruns = dirrunsUnique);
                    }
                    bySet && ((elem = !matcher && elem) && matchedCount--, seed && unmatched.push(elem));
                }
                if (matchedCount += i, bySet && i !== matchedCount) {
                    for (j = 0; matcher = setMatchers[j++]; ) matcher(unmatched, setMatched, context, xml);
                    if (seed) {
                        if (matchedCount > 0) for (;i--; ) unmatched[i] || setMatched[i] || (setMatched[i] = pop.call(results));
                        setMatched = condense(setMatched);
                    }
                    push.apply(results, setMatched), outermost && !seed && setMatched.length > 0 && matchedCount + setMatchers.length > 1 && Sizzle.uniqueSort(results);
                }
                return outermost && (dirruns = dirrunsUnique, outermostContext = contextBackup), 
                unmatched;
            };
            return bySet ? markFunction(superMatcher) :superMatcher;
        }
        function multipleContexts(selector, contexts, results) {
            for (var i = 0, len = contexts.length; len > i; i++) Sizzle(selector, contexts[i], results);
            return results;
        }
        function select(selector, context, results, seed) {
            var i, tokens, token, type, find, match = tokenize(selector);
            if (!seed && 1 === match.length) {
                if (tokens = match[0] = match[0].slice(0), tokens.length > 2 && "ID" === (token = tokens[0]).type && support.getById && 9 === context.nodeType && documentIsHTML && Expr.relative[tokens[1].type]) {
                    if (context = (Expr.find.ID(token.matches[0].replace(runescape, funescape), context) || [])[0], 
                    !context) return results;
                    selector = selector.slice(tokens.shift().value.length);
                }
                for (i = matchExpr.needsContext.test(selector) ? 0 :tokens.length; i-- && (token = tokens[i], 
                !Expr.relative[type = token.type]); ) if ((find = Expr.find[type]) && (seed = find(token.matches[0].replace(runescape, funescape), rsibling.test(tokens[0].type) && testContext(context.parentNode) || context))) {
                    if (tokens.splice(i, 1), selector = seed.length && toSelector(tokens), !selector) return push.apply(results, seed), 
                    results;
                    break;
                }
            }
            return compile(selector, match)(seed, context, !documentIsHTML, results, rsibling.test(selector) && testContext(context.parentNode) || context), 
            results;
        }
        var i, support, Expr, getText, isXML, compile, outermostContext, sortInput, hasDuplicate, setDocument, document, docElem, documentIsHTML, rbuggyQSA, rbuggyMatches, matches, contains, expando = "sizzle" + -new Date(), preferredDoc = window.document, dirruns = 0, done = 0, classCache = createCache(), tokenCache = createCache(), compilerCache = createCache(), sortOrder = function(a, b) {
            return a === b && (hasDuplicate = !0), 0;
        }, strundefined = "undefined", MAX_NEGATIVE = 1 << 31, hasOwn = {}.hasOwnProperty, arr = [], pop = arr.pop, push_native = arr.push, push = arr.push, slice = arr.slice, indexOf = arr.indexOf || function(elem) {
            for (var i = 0, len = this.length; len > i; i++) if (this[i] === elem) return i;
            return -1;
        }, booleans = "checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped", whitespace = "[\\x20\\t\\r\\n\\f]", characterEncoding = "(?:\\\\.|[\\w-]|[^\\x00-\\xa0])+", identifier = characterEncoding.replace("w", "w#"), attributes = "\\[" + whitespace + "*(" + characterEncoding + ")" + whitespace + "*(?:([*^$|!~]?=)" + whitespace + "*(?:(['\"])((?:\\\\.|[^\\\\])*?)\\3|(" + identifier + ")|)|)" + whitespace + "*\\]", pseudos = ":(" + characterEncoding + ")(?:\\(((['\"])((?:\\\\.|[^\\\\])*?)\\3|((?:\\\\.|[^\\\\()[\\]]|" + attributes.replace(3, 8) + ")*)|.*)\\)|)", rtrim = new RegExp("^" + whitespace + "+|((?:^|[^\\\\])(?:\\\\.)*)" + whitespace + "+$", "g"), rcomma = new RegExp("^" + whitespace + "*," + whitespace + "*"), rcombinators = new RegExp("^" + whitespace + "*([>+~]|" + whitespace + ")" + whitespace + "*"), rattributeQuotes = new RegExp("=" + whitespace + "*([^\\]'\"]*?)" + whitespace + "*\\]", "g"), rpseudo = new RegExp(pseudos), ridentifier = new RegExp("^" + identifier + "$"), matchExpr = {
            ID:new RegExp("^#(" + characterEncoding + ")"),
            CLASS:new RegExp("^\\.(" + characterEncoding + ")"),
            TAG:new RegExp("^(" + characterEncoding.replace("w", "w*") + ")"),
            ATTR:new RegExp("^" + attributes),
            PSEUDO:new RegExp("^" + pseudos),
            CHILD:new RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\(" + whitespace + "*(even|odd|(([+-]|)(\\d*)n|)" + whitespace + "*(?:([+-]|)" + whitespace + "*(\\d+)|))" + whitespace + "*\\)|)", "i"),
            bool:new RegExp("^(?:" + booleans + ")$", "i"),
            needsContext:new RegExp("^" + whitespace + "*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\(" + whitespace + "*((?:-\\d)?\\d*)" + whitespace + "*\\)|)(?=[^-]|$)", "i")
        }, rinputs = /^(?:input|select|textarea|button)$/i, rheader = /^h\d$/i, rnative = /^[^{]+\{\s*\[native \w/, rquickExpr = /^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/, rsibling = /[+~]/, rescape = /'|\\/g, runescape = new RegExp("\\\\([\\da-f]{1,6}" + whitespace + "?|(" + whitespace + ")|.)", "ig"), funescape = function(_, escaped, escapedWhitespace) {
            var high = "0x" + escaped - 65536;
            return high !== high || escapedWhitespace ? escaped :0 > high ? String.fromCharCode(high + 65536) :String.fromCharCode(high >> 10 | 55296, 1023 & high | 56320);
        };
        try {
            push.apply(arr = slice.call(preferredDoc.childNodes), preferredDoc.childNodes), 
            arr[preferredDoc.childNodes.length].nodeType;
        } catch (e) {
            push = {
                apply:arr.length ? function(target, els) {
                    push_native.apply(target, slice.call(els));
                } :function(target, els) {
                    for (var j = target.length, i = 0; target[j++] = els[i++]; ) ;
                    target.length = j - 1;
                }
            };
        }
        support = Sizzle.support = {}, isXML = Sizzle.isXML = function(elem) {
            var documentElement = elem && (elem.ownerDocument || elem).documentElement;
            return documentElement ? "HTML" !== documentElement.nodeName :!1;
        }, setDocument = Sizzle.setDocument = function(node) {
            var hasCompare, doc = node ? node.ownerDocument || node :preferredDoc, parent = doc.defaultView;
            return doc !== document && 9 === doc.nodeType && doc.documentElement ? (document = doc, 
            docElem = doc.documentElement, documentIsHTML = !isXML(doc), parent && parent !== parent.top && (parent.addEventListener ? parent.addEventListener("unload", function() {
                setDocument();
            }, !1) :parent.attachEvent && parent.attachEvent("onunload", function() {
                setDocument();
            })), support.attributes = assert(function(div) {
                return div.className = "i", !div.getAttribute("className");
            }), support.getElementsByTagName = assert(function(div) {
                return div.appendChild(doc.createComment("")), !div.getElementsByTagName("*").length;
            }), support.getElementsByClassName = rnative.test(doc.getElementsByClassName) && assert(function(div) {
                return div.innerHTML = "<div class='a'></div><div class='a i'></div>", div.firstChild.className = "i", 
                2 === div.getElementsByClassName("i").length;
            }), support.getById = assert(function(div) {
                return docElem.appendChild(div).id = expando, !doc.getElementsByName || !doc.getElementsByName(expando).length;
            }), support.getById ? (Expr.find.ID = function(id, context) {
                if (typeof context.getElementById !== strundefined && documentIsHTML) {
                    var m = context.getElementById(id);
                    return m && m.parentNode ? [ m ] :[];
                }
            }, Expr.filter.ID = function(id) {
                var attrId = id.replace(runescape, funescape);
                return function(elem) {
                    return elem.getAttribute("id") === attrId;
                };
            }) :(delete Expr.find.ID, Expr.filter.ID = function(id) {
                var attrId = id.replace(runescape, funescape);
                return function(elem) {
                    var node = typeof elem.getAttributeNode !== strundefined && elem.getAttributeNode("id");
                    return node && node.value === attrId;
                };
            }), Expr.find.TAG = support.getElementsByTagName ? function(tag, context) {
                return typeof context.getElementsByTagName !== strundefined ? context.getElementsByTagName(tag) :void 0;
            } :function(tag, context) {
                var elem, tmp = [], i = 0, results = context.getElementsByTagName(tag);
                if ("*" === tag) {
                    for (;elem = results[i++]; ) 1 === elem.nodeType && tmp.push(elem);
                    return tmp;
                }
                return results;
            }, Expr.find.CLASS = support.getElementsByClassName && function(className, context) {
                return typeof context.getElementsByClassName !== strundefined && documentIsHTML ? context.getElementsByClassName(className) :void 0;
            }, rbuggyMatches = [], rbuggyQSA = [], (support.qsa = rnative.test(doc.querySelectorAll)) && (assert(function(div) {
                div.innerHTML = "<select t=''><option selected=''></option></select>", div.querySelectorAll("[t^='']").length && rbuggyQSA.push("[*^$]=" + whitespace + "*(?:''|\"\")"), 
                div.querySelectorAll("[selected]").length || rbuggyQSA.push("\\[" + whitespace + "*(?:value|" + booleans + ")"), 
                div.querySelectorAll(":checked").length || rbuggyQSA.push(":checked");
            }), assert(function(div) {
                var input = doc.createElement("input");
                input.setAttribute("type", "hidden"), div.appendChild(input).setAttribute("name", "D"), 
                div.querySelectorAll("[name=d]").length && rbuggyQSA.push("name" + whitespace + "*[*^$|!~]?="), 
                div.querySelectorAll(":enabled").length || rbuggyQSA.push(":enabled", ":disabled"), 
                div.querySelectorAll("*,:x"), rbuggyQSA.push(",.*:");
            })), (support.matchesSelector = rnative.test(matches = docElem.webkitMatchesSelector || docElem.mozMatchesSelector || docElem.oMatchesSelector || docElem.msMatchesSelector)) && assert(function(div) {
                support.disconnectedMatch = matches.call(div, "div"), matches.call(div, "[s!='']:x"), 
                rbuggyMatches.push("!=", pseudos);
            }), rbuggyQSA = rbuggyQSA.length && new RegExp(rbuggyQSA.join("|")), rbuggyMatches = rbuggyMatches.length && new RegExp(rbuggyMatches.join("|")), 
            hasCompare = rnative.test(docElem.compareDocumentPosition), contains = hasCompare || rnative.test(docElem.contains) ? function(a, b) {
                var adown = 9 === a.nodeType ? a.documentElement :a, bup = b && b.parentNode;
                return a === bup || !(!bup || 1 !== bup.nodeType || !(adown.contains ? adown.contains(bup) :a.compareDocumentPosition && 16 & a.compareDocumentPosition(bup)));
            } :function(a, b) {
                if (b) for (;b = b.parentNode; ) if (b === a) return !0;
                return !1;
            }, sortOrder = hasCompare ? function(a, b) {
                if (a === b) return hasDuplicate = !0, 0;
                var compare = !a.compareDocumentPosition - !b.compareDocumentPosition;
                return compare ? compare :(compare = (a.ownerDocument || a) === (b.ownerDocument || b) ? a.compareDocumentPosition(b) :1, 
                1 & compare || !support.sortDetached && b.compareDocumentPosition(a) === compare ? a === doc || a.ownerDocument === preferredDoc && contains(preferredDoc, a) ? -1 :b === doc || b.ownerDocument === preferredDoc && contains(preferredDoc, b) ? 1 :sortInput ? indexOf.call(sortInput, a) - indexOf.call(sortInput, b) :0 :4 & compare ? -1 :1);
            } :function(a, b) {
                if (a === b) return hasDuplicate = !0, 0;
                var cur, i = 0, aup = a.parentNode, bup = b.parentNode, ap = [ a ], bp = [ b ];
                if (!aup || !bup) return a === doc ? -1 :b === doc ? 1 :aup ? -1 :bup ? 1 :sortInput ? indexOf.call(sortInput, a) - indexOf.call(sortInput, b) :0;
                if (aup === bup) return siblingCheck(a, b);
                for (cur = a; cur = cur.parentNode; ) ap.unshift(cur);
                for (cur = b; cur = cur.parentNode; ) bp.unshift(cur);
                for (;ap[i] === bp[i]; ) i++;
                return i ? siblingCheck(ap[i], bp[i]) :ap[i] === preferredDoc ? -1 :bp[i] === preferredDoc ? 1 :0;
            }, doc) :document;
        }, Sizzle.matches = function(expr, elements) {
            return Sizzle(expr, null, null, elements);
        }, Sizzle.matchesSelector = function(elem, expr) {
            if ((elem.ownerDocument || elem) !== document && setDocument(elem), expr = expr.replace(rattributeQuotes, "='$1']"), 
            !(!support.matchesSelector || !documentIsHTML || rbuggyMatches && rbuggyMatches.test(expr) || rbuggyQSA && rbuggyQSA.test(expr))) try {
                var ret = matches.call(elem, expr);
                if (ret || support.disconnectedMatch || elem.document && 11 !== elem.document.nodeType) return ret;
            } catch (e) {}
            return Sizzle(expr, document, null, [ elem ]).length > 0;
        }, Sizzle.contains = function(context, elem) {
            return (context.ownerDocument || context) !== document && setDocument(context), 
            contains(context, elem);
        }, Sizzle.attr = function(elem, name) {
            (elem.ownerDocument || elem) !== document && setDocument(elem);
            var fn = Expr.attrHandle[name.toLowerCase()], val = fn && hasOwn.call(Expr.attrHandle, name.toLowerCase()) ? fn(elem, name, !documentIsHTML) :void 0;
            return void 0 !== val ? val :support.attributes || !documentIsHTML ? elem.getAttribute(name) :(val = elem.getAttributeNode(name)) && val.specified ? val.value :null;
        }, Sizzle.error = function(msg) {
            throw new Error("Syntax error, unrecognized expression: " + msg);
        }, Sizzle.uniqueSort = function(results) {
            var elem, duplicates = [], j = 0, i = 0;
            if (hasDuplicate = !support.detectDuplicates, sortInput = !support.sortStable && results.slice(0), 
            results.sort(sortOrder), hasDuplicate) {
                for (;elem = results[i++]; ) elem === results[i] && (j = duplicates.push(i));
                for (;j--; ) results.splice(duplicates[j], 1);
            }
            return sortInput = null, results;
        }, getText = Sizzle.getText = function(elem) {
            var node, ret = "", i = 0, nodeType = elem.nodeType;
            if (nodeType) {
                if (1 === nodeType || 9 === nodeType || 11 === nodeType) {
                    if ("string" == typeof elem.textContent) return elem.textContent;
                    for (elem = elem.firstChild; elem; elem = elem.nextSibling) ret += getText(elem);
                } else if (3 === nodeType || 4 === nodeType) return elem.nodeValue;
            } else for (;node = elem[i++]; ) ret += getText(node);
            return ret;
        }, Expr = Sizzle.selectors = {
            cacheLength:50,
            createPseudo:markFunction,
            match:matchExpr,
            attrHandle:{},
            find:{},
            relative:{
                ">":{
                    dir:"parentNode",
                    first:!0
                },
                " ":{
                    dir:"parentNode"
                },
                "+":{
                    dir:"previousSibling",
                    first:!0
                },
                "~":{
                    dir:"previousSibling"
                }
            },
            preFilter:{
                ATTR:function(match) {
                    return match[1] = match[1].replace(runescape, funescape), match[3] = (match[4] || match[5] || "").replace(runescape, funescape), 
                    "~=" === match[2] && (match[3] = " " + match[3] + " "), match.slice(0, 4);
                },
                CHILD:function(match) {
                    return match[1] = match[1].toLowerCase(), "nth" === match[1].slice(0, 3) ? (match[3] || Sizzle.error(match[0]), 
                    match[4] = +(match[4] ? match[5] + (match[6] || 1) :2 * ("even" === match[3] || "odd" === match[3])), 
                    match[5] = +(match[7] + match[8] || "odd" === match[3])) :match[3] && Sizzle.error(match[0]), 
                    match;
                },
                PSEUDO:function(match) {
                    var excess, unquoted = !match[5] && match[2];
                    return matchExpr.CHILD.test(match[0]) ? null :(match[3] && void 0 !== match[4] ? match[2] = match[4] :unquoted && rpseudo.test(unquoted) && (excess = tokenize(unquoted, !0)) && (excess = unquoted.indexOf(")", unquoted.length - excess) - unquoted.length) && (match[0] = match[0].slice(0, excess), 
                    match[2] = unquoted.slice(0, excess)), match.slice(0, 3));
                }
            },
            filter:{
                TAG:function(nodeNameSelector) {
                    var nodeName = nodeNameSelector.replace(runescape, funescape).toLowerCase();
                    return "*" === nodeNameSelector ? function() {
                        return !0;
                    } :function(elem) {
                        return elem.nodeName && elem.nodeName.toLowerCase() === nodeName;
                    };
                },
                CLASS:function(className) {
                    var pattern = classCache[className + " "];
                    return pattern || (pattern = new RegExp("(^|" + whitespace + ")" + className + "(" + whitespace + "|$)")) && classCache(className, function(elem) {
                        return pattern.test("string" == typeof elem.className && elem.className || typeof elem.getAttribute !== strundefined && elem.getAttribute("class") || "");
                    });
                },
                ATTR:function(name, operator, check) {
                    return function(elem) {
                        var result = Sizzle.attr(elem, name);
                        return null == result ? "!=" === operator :operator ? (result += "", "=" === operator ? result === check :"!=" === operator ? result !== check :"^=" === operator ? check && 0 === result.indexOf(check) :"*=" === operator ? check && result.indexOf(check) > -1 :"$=" === operator ? check && result.slice(-check.length) === check :"~=" === operator ? (" " + result + " ").indexOf(check) > -1 :"|=" === operator ? result === check || result.slice(0, check.length + 1) === check + "-" :!1) :!0;
                    };
                },
                CHILD:function(type, what, argument, first, last) {
                    var simple = "nth" !== type.slice(0, 3), forward = "last" !== type.slice(-4), ofType = "of-type" === what;
                    return 1 === first && 0 === last ? function(elem) {
                        return !!elem.parentNode;
                    } :function(elem, context, xml) {
                        var cache, outerCache, node, diff, nodeIndex, start, dir = simple !== forward ? "nextSibling" :"previousSibling", parent = elem.parentNode, name = ofType && elem.nodeName.toLowerCase(), useCache = !xml && !ofType;
                        if (parent) {
                            if (simple) {
                                for (;dir; ) {
                                    for (node = elem; node = node[dir]; ) if (ofType ? node.nodeName.toLowerCase() === name :1 === node.nodeType) return !1;
                                    start = dir = "only" === type && !start && "nextSibling";
                                }
                                return !0;
                            }
                            if (start = [ forward ? parent.firstChild :parent.lastChild ], forward && useCache) {
                                for (outerCache = parent[expando] || (parent[expando] = {}), cache = outerCache[type] || [], 
                                nodeIndex = cache[0] === dirruns && cache[1], diff = cache[0] === dirruns && cache[2], 
                                node = nodeIndex && parent.childNodes[nodeIndex]; node = ++nodeIndex && node && node[dir] || (diff = nodeIndex = 0) || start.pop(); ) if (1 === node.nodeType && ++diff && node === elem) {
                                    outerCache[type] = [ dirruns, nodeIndex, diff ];
                                    break;
                                }
                            } else if (useCache && (cache = (elem[expando] || (elem[expando] = {}))[type]) && cache[0] === dirruns) diff = cache[1]; else for (;(node = ++nodeIndex && node && node[dir] || (diff = nodeIndex = 0) || start.pop()) && ((ofType ? node.nodeName.toLowerCase() !== name :1 !== node.nodeType) || !++diff || (useCache && ((node[expando] || (node[expando] = {}))[type] = [ dirruns, diff ]), 
                            node !== elem)); ) ;
                            return diff -= last, diff === first || diff % first === 0 && diff / first >= 0;
                        }
                    };
                },
                PSEUDO:function(pseudo, argument) {
                    var args, fn = Expr.pseudos[pseudo] || Expr.setFilters[pseudo.toLowerCase()] || Sizzle.error("unsupported pseudo: " + pseudo);
                    return fn[expando] ? fn(argument) :fn.length > 1 ? (args = [ pseudo, pseudo, "", argument ], 
                    Expr.setFilters.hasOwnProperty(pseudo.toLowerCase()) ? markFunction(function(seed, matches) {
                        for (var idx, matched = fn(seed, argument), i = matched.length; i--; ) idx = indexOf.call(seed, matched[i]), 
                        seed[idx] = !(matches[idx] = matched[i]);
                    }) :function(elem) {
                        return fn(elem, 0, args);
                    }) :fn;
                }
            },
            pseudos:{
                not:markFunction(function(selector) {
                    var input = [], results = [], matcher = compile(selector.replace(rtrim, "$1"));
                    return matcher[expando] ? markFunction(function(seed, matches, context, xml) {
                        for (var elem, unmatched = matcher(seed, null, xml, []), i = seed.length; i--; ) (elem = unmatched[i]) && (seed[i] = !(matches[i] = elem));
                    }) :function(elem, context, xml) {
                        return input[0] = elem, matcher(input, null, xml, results), !results.pop();
                    };
                }),
                has:markFunction(function(selector) {
                    return function(elem) {
                        return Sizzle(selector, elem).length > 0;
                    };
                }),
                contains:markFunction(function(text) {
                    return function(elem) {
                        return (elem.textContent || elem.innerText || getText(elem)).indexOf(text) > -1;
                    };
                }),
                lang:markFunction(function(lang) {
                    return ridentifier.test(lang || "") || Sizzle.error("unsupported lang: " + lang), 
                    lang = lang.replace(runescape, funescape).toLowerCase(), function(elem) {
                        var elemLang;
                        do if (elemLang = documentIsHTML ? elem.lang :elem.getAttribute("xml:lang") || elem.getAttribute("lang")) return elemLang = elemLang.toLowerCase(), 
                        elemLang === lang || 0 === elemLang.indexOf(lang + "-"); while ((elem = elem.parentNode) && 1 === elem.nodeType);
                        return !1;
                    };
                }),
                target:function(elem) {
                    var hash = window.location && window.location.hash;
                    return hash && hash.slice(1) === elem.id;
                },
                root:function(elem) {
                    return elem === docElem;
                },
                focus:function(elem) {
                    return elem === document.activeElement && (!document.hasFocus || document.hasFocus()) && !!(elem.type || elem.href || ~elem.tabIndex);
                },
                enabled:function(elem) {
                    return elem.disabled === !1;
                },
                disabled:function(elem) {
                    return elem.disabled === !0;
                },
                checked:function(elem) {
                    var nodeName = elem.nodeName.toLowerCase();
                    return "input" === nodeName && !!elem.checked || "option" === nodeName && !!elem.selected;
                },
                selected:function(elem) {
                    return elem.parentNode && elem.parentNode.selectedIndex, elem.selected === !0;
                },
                empty:function(elem) {
                    for (elem = elem.firstChild; elem; elem = elem.nextSibling) if (elem.nodeType < 6) return !1;
                    return !0;
                },
                parent:function(elem) {
                    return !Expr.pseudos.empty(elem);
                },
                header:function(elem) {
                    return rheader.test(elem.nodeName);
                },
                input:function(elem) {
                    return rinputs.test(elem.nodeName);
                },
                button:function(elem) {
                    var name = elem.nodeName.toLowerCase();
                    return "input" === name && "button" === elem.type || "button" === name;
                },
                text:function(elem) {
                    var attr;
                    return "input" === elem.nodeName.toLowerCase() && "text" === elem.type && (null == (attr = elem.getAttribute("type")) || "text" === attr.toLowerCase());
                },
                first:createPositionalPseudo(function() {
                    return [ 0 ];
                }),
                last:createPositionalPseudo(function(matchIndexes, length) {
                    return [ length - 1 ];
                }),
                eq:createPositionalPseudo(function(matchIndexes, length, argument) {
                    return [ 0 > argument ? argument + length :argument ];
                }),
                even:createPositionalPseudo(function(matchIndexes, length) {
                    for (var i = 0; length > i; i += 2) matchIndexes.push(i);
                    return matchIndexes;
                }),
                odd:createPositionalPseudo(function(matchIndexes, length) {
                    for (var i = 1; length > i; i += 2) matchIndexes.push(i);
                    return matchIndexes;
                }),
                lt:createPositionalPseudo(function(matchIndexes, length, argument) {
                    for (var i = 0 > argument ? argument + length :argument; --i >= 0; ) matchIndexes.push(i);
                    return matchIndexes;
                }),
                gt:createPositionalPseudo(function(matchIndexes, length, argument) {
                    for (var i = 0 > argument ? argument + length :argument; ++i < length; ) matchIndexes.push(i);
                    return matchIndexes;
                })
            }
        }, Expr.pseudos.nth = Expr.pseudos.eq;
        for (i in {
            radio:!0,
            checkbox:!0,
            file:!0,
            password:!0,
            image:!0
        }) Expr.pseudos[i] = createInputPseudo(i);
        for (i in {
            submit:!0,
            reset:!0
        }) Expr.pseudos[i] = createButtonPseudo(i);
        return setFilters.prototype = Expr.filters = Expr.pseudos, Expr.setFilters = new setFilters(), 
        compile = Sizzle.compile = function(selector, group) {
            var i, setMatchers = [], elementMatchers = [], cached = compilerCache[selector + " "];
            if (!cached) {
                for (group || (group = tokenize(selector)), i = group.length; i--; ) cached = matcherFromTokens(group[i]), 
                cached[expando] ? setMatchers.push(cached) :elementMatchers.push(cached);
                cached = compilerCache(selector, matcherFromGroupMatchers(elementMatchers, setMatchers));
            }
            return cached;
        }, support.sortStable = expando.split("").sort(sortOrder).join("") === expando, 
        support.detectDuplicates = !!hasDuplicate, setDocument(), support.sortDetached = assert(function(div1) {
            return 1 & div1.compareDocumentPosition(document.createElement("div"));
        }), assert(function(div) {
            return div.innerHTML = "<a href='#'></a>", "#" === div.firstChild.getAttribute("href");
        }) || addHandle("type|href|height|width", function(elem, name, isXML) {
            return isXML ? void 0 :elem.getAttribute(name, "type" === name.toLowerCase() ? 1 :2);
        }), support.attributes && assert(function(div) {
            return div.innerHTML = "<input/>", div.firstChild.setAttribute("value", ""), "" === div.firstChild.getAttribute("value");
        }) || addHandle("value", function(elem, name, isXML) {
            return isXML || "input" !== elem.nodeName.toLowerCase() ? void 0 :elem.defaultValue;
        }), assert(function(div) {
            return null == div.getAttribute("disabled");
        }) || addHandle(booleans, function(elem, name, isXML) {
            var val;
            return isXML ? void 0 :elem[name] === !0 ? name.toLowerCase() :(val = elem.getAttributeNode(name)) && val.specified ? val.value :null;
        }), Sizzle;
    }(window);
    jQuery.find = Sizzle, jQuery.expr = Sizzle.selectors, jQuery.expr[":"] = jQuery.expr.pseudos, 
    jQuery.unique = Sizzle.uniqueSort, jQuery.text = Sizzle.getText, jQuery.isXMLDoc = Sizzle.isXML, 
    jQuery.contains = Sizzle.contains;
    var rneedsContext = jQuery.expr.match.needsContext, rsingleTag = /^<(\w+)\s*\/?>(?:<\/\1>|)$/, risSimple = /^.[^:#\[\.,]*$/;
    jQuery.filter = function(expr, elems, not) {
        var elem = elems[0];
        return not && (expr = ":not(" + expr + ")"), 1 === elems.length && 1 === elem.nodeType ? jQuery.find.matchesSelector(elem, expr) ? [ elem ] :[] :jQuery.find.matches(expr, jQuery.grep(elems, function(elem) {
            return 1 === elem.nodeType;
        }));
    }, jQuery.fn.extend({
        find:function(selector) {
            var i, ret = [], self = this, len = self.length;
            if ("string" != typeof selector) return this.pushStack(jQuery(selector).filter(function() {
                for (i = 0; len > i; i++) if (jQuery.contains(self[i], this)) return !0;
            }));
            for (i = 0; len > i; i++) jQuery.find(selector, self[i], ret);
            return ret = this.pushStack(len > 1 ? jQuery.unique(ret) :ret), ret.selector = this.selector ? this.selector + " " + selector :selector, 
            ret;
        },
        filter:function(selector) {
            return this.pushStack(winnow(this, selector || [], !1));
        },
        not:function(selector) {
            return this.pushStack(winnow(this, selector || [], !0));
        },
        is:function(selector) {
            return !!winnow(this, "string" == typeof selector && rneedsContext.test(selector) ? jQuery(selector) :selector || [], !1).length;
        }
    });
    var rootjQuery, document = window.document, rquickExpr = /^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]*))$/, init = jQuery.fn.init = function(selector, context) {
        var match, elem;
        if (!selector) return this;
        if ("string" == typeof selector) {
            if (match = "<" === selector.charAt(0) && ">" === selector.charAt(selector.length - 1) && selector.length >= 3 ? [ null, selector, null ] :rquickExpr.exec(selector), 
            !match || !match[1] && context) return !context || context.jquery ? (context || rootjQuery).find(selector) :this.constructor(context).find(selector);
            if (match[1]) {
                if (context = context instanceof jQuery ? context[0] :context, jQuery.merge(this, jQuery.parseHTML(match[1], context && context.nodeType ? context.ownerDocument || context :document, !0)), 
                rsingleTag.test(match[1]) && jQuery.isPlainObject(context)) for (match in context) jQuery.isFunction(this[match]) ? this[match](context[match]) :this.attr(match, context[match]);
                return this;
            }
            if (elem = document.getElementById(match[2]), elem && elem.parentNode) {
                if (elem.id !== match[2]) return rootjQuery.find(selector);
                this.length = 1, this[0] = elem;
            }
            return this.context = document, this.selector = selector, this;
        }
        return selector.nodeType ? (this.context = this[0] = selector, this.length = 1, 
        this) :jQuery.isFunction(selector) ? "undefined" != typeof rootjQuery.ready ? rootjQuery.ready(selector) :selector(jQuery) :(void 0 !== selector.selector && (this.selector = selector.selector, 
        this.context = selector.context), jQuery.makeArray(selector, this));
    };
    init.prototype = jQuery.fn, rootjQuery = jQuery(document);
    var rparentsprev = /^(?:parents|prev(?:Until|All))/, guaranteedUnique = {
        children:!0,
        contents:!0,
        next:!0,
        prev:!0
    };
    jQuery.extend({
        dir:function(elem, dir, until) {
            for (var matched = [], cur = elem[dir]; cur && 9 !== cur.nodeType && (void 0 === until || 1 !== cur.nodeType || !jQuery(cur).is(until)); ) 1 === cur.nodeType && matched.push(cur), 
            cur = cur[dir];
            return matched;
        },
        sibling:function(n, elem) {
            for (var r = []; n; n = n.nextSibling) 1 === n.nodeType && n !== elem && r.push(n);
            return r;
        }
    }), jQuery.fn.extend({
        has:function(target) {
            var i, targets = jQuery(target, this), len = targets.length;
            return this.filter(function() {
                for (i = 0; len > i; i++) if (jQuery.contains(this, targets[i])) return !0;
            });
        },
        closest:function(selectors, context) {
            for (var cur, i = 0, l = this.length, matched = [], pos = rneedsContext.test(selectors) || "string" != typeof selectors ? jQuery(selectors, context || this.context) :0; l > i; i++) for (cur = this[i]; cur && cur !== context; cur = cur.parentNode) if (cur.nodeType < 11 && (pos ? pos.index(cur) > -1 :1 === cur.nodeType && jQuery.find.matchesSelector(cur, selectors))) {
                matched.push(cur);
                break;
            }
            return this.pushStack(matched.length > 1 ? jQuery.unique(matched) :matched);
        },
        index:function(elem) {
            return elem ? "string" == typeof elem ? jQuery.inArray(this[0], jQuery(elem)) :jQuery.inArray(elem.jquery ? elem[0] :elem, this) :this[0] && this[0].parentNode ? this.first().prevAll().length :-1;
        },
        add:function(selector, context) {
            return this.pushStack(jQuery.unique(jQuery.merge(this.get(), jQuery(selector, context))));
        },
        addBack:function(selector) {
            return this.add(null == selector ? this.prevObject :this.prevObject.filter(selector));
        }
    }), jQuery.each({
        parent:function(elem) {
            var parent = elem.parentNode;
            return parent && 11 !== parent.nodeType ? parent :null;
        },
        parents:function(elem) {
            return jQuery.dir(elem, "parentNode");
        },
        parentsUntil:function(elem, i, until) {
            return jQuery.dir(elem, "parentNode", until);
        },
        next:function(elem) {
            return sibling(elem, "nextSibling");
        },
        prev:function(elem) {
            return sibling(elem, "previousSibling");
        },
        nextAll:function(elem) {
            return jQuery.dir(elem, "nextSibling");
        },
        prevAll:function(elem) {
            return jQuery.dir(elem, "previousSibling");
        },
        nextUntil:function(elem, i, until) {
            return jQuery.dir(elem, "nextSibling", until);
        },
        prevUntil:function(elem, i, until) {
            return jQuery.dir(elem, "previousSibling", until);
        },
        siblings:function(elem) {
            return jQuery.sibling((elem.parentNode || {}).firstChild, elem);
        },
        children:function(elem) {
            return jQuery.sibling(elem.firstChild);
        },
        contents:function(elem) {
            return jQuery.nodeName(elem, "iframe") ? elem.contentDocument || elem.contentWindow.document :jQuery.merge([], elem.childNodes);
        }
    }, function(name, fn) {
        jQuery.fn[name] = function(until, selector) {
            var ret = jQuery.map(this, fn, until);
            return "Until" !== name.slice(-5) && (selector = until), selector && "string" == typeof selector && (ret = jQuery.filter(selector, ret)), 
            this.length > 1 && (guaranteedUnique[name] || (ret = jQuery.unique(ret)), rparentsprev.test(name) && (ret = ret.reverse())), 
            this.pushStack(ret);
        };
    });
    var rnotwhite = /\S+/g, optionsCache = {};
    jQuery.Callbacks = function(options) {
        options = "string" == typeof options ? optionsCache[options] || createOptions(options) :jQuery.extend({}, options);
        var firing, memory, fired, firingLength, firingIndex, firingStart, list = [], stack = !options.once && [], fire = function(data) {
            for (memory = options.memory && data, fired = !0, firingIndex = firingStart || 0, 
            firingStart = 0, firingLength = list.length, firing = !0; list && firingLength > firingIndex; firingIndex++) if (list[firingIndex].apply(data[0], data[1]) === !1 && options.stopOnFalse) {
                memory = !1;
                break;
            }
            firing = !1, list && (stack ? stack.length && fire(stack.shift()) :memory ? list = [] :self.disable());
        }, self = {
            add:function() {
                if (list) {
                    var start = list.length;
                    !function add(args) {
                        jQuery.each(args, function(_, arg) {
                            var type = jQuery.type(arg);
                            "function" === type ? options.unique && self.has(arg) || list.push(arg) :arg && arg.length && "string" !== type && add(arg);
                        });
                    }(arguments), firing ? firingLength = list.length :memory && (firingStart = start, 
                    fire(memory));
                }
                return this;
            },
            remove:function() {
                return list && jQuery.each(arguments, function(_, arg) {
                    for (var index; (index = jQuery.inArray(arg, list, index)) > -1; ) list.splice(index, 1), 
                    firing && (firingLength >= index && firingLength--, firingIndex >= index && firingIndex--);
                }), this;
            },
            has:function(fn) {
                return fn ? jQuery.inArray(fn, list) > -1 :!(!list || !list.length);
            },
            empty:function() {
                return list = [], firingLength = 0, this;
            },
            disable:function() {
                return list = stack = memory = void 0, this;
            },
            disabled:function() {
                return !list;
            },
            lock:function() {
                return stack = void 0, memory || self.disable(), this;
            },
            locked:function() {
                return !stack;
            },
            fireWith:function(context, args) {
                return !list || fired && !stack || (args = args || [], args = [ context, args.slice ? args.slice() :args ], 
                firing ? stack.push(args) :fire(args)), this;
            },
            fire:function() {
                return self.fireWith(this, arguments), this;
            },
            fired:function() {
                return !!fired;
            }
        };
        return self;
    }, jQuery.extend({
        Deferred:function(func) {
            var tuples = [ [ "resolve", "done", jQuery.Callbacks("once memory"), "resolved" ], [ "reject", "fail", jQuery.Callbacks("once memory"), "rejected" ], [ "notify", "progress", jQuery.Callbacks("memory") ] ], state = "pending", promise = {
                state:function() {
                    return state;
                },
                always:function() {
                    return deferred.done(arguments).fail(arguments), this;
                },
                then:function() {
                    var fns = arguments;
                    return jQuery.Deferred(function(newDefer) {
                        jQuery.each(tuples, function(i, tuple) {
                            var fn = jQuery.isFunction(fns[i]) && fns[i];
                            deferred[tuple[1]](function() {
                                var returned = fn && fn.apply(this, arguments);
                                returned && jQuery.isFunction(returned.promise) ? returned.promise().done(newDefer.resolve).fail(newDefer.reject).progress(newDefer.notify) :newDefer[tuple[0] + "With"](this === promise ? newDefer.promise() :this, fn ? [ returned ] :arguments);
                            });
                        }), fns = null;
                    }).promise();
                },
                promise:function(obj) {
                    return null != obj ? jQuery.extend(obj, promise) :promise;
                }
            }, deferred = {};
            return promise.pipe = promise.then, jQuery.each(tuples, function(i, tuple) {
                var list = tuple[2], stateString = tuple[3];
                promise[tuple[1]] = list.add, stateString && list.add(function() {
                    state = stateString;
                }, tuples[1 ^ i][2].disable, tuples[2][2].lock), deferred[tuple[0]] = function() {
                    return deferred[tuple[0] + "With"](this === deferred ? promise :this, arguments), 
                    this;
                }, deferred[tuple[0] + "With"] = list.fireWith;
            }), promise.promise(deferred), func && func.call(deferred, deferred), deferred;
        },
        when:function(subordinate) {
            var progressValues, progressContexts, resolveContexts, i = 0, resolveValues = slice.call(arguments), length = resolveValues.length, remaining = 1 !== length || subordinate && jQuery.isFunction(subordinate.promise) ? length :0, deferred = 1 === remaining ? subordinate :jQuery.Deferred(), updateFunc = function(i, contexts, values) {
                return function(value) {
                    contexts[i] = this, values[i] = arguments.length > 1 ? slice.call(arguments) :value, 
                    values === progressValues ? deferred.notifyWith(contexts, values) :--remaining || deferred.resolveWith(contexts, values);
                };
            };
            if (length > 1) for (progressValues = new Array(length), progressContexts = new Array(length), 
            resolveContexts = new Array(length); length > i; i++) resolveValues[i] && jQuery.isFunction(resolveValues[i].promise) ? resolveValues[i].promise().done(updateFunc(i, resolveContexts, resolveValues)).fail(deferred.reject).progress(updateFunc(i, progressContexts, progressValues)) :--remaining;
            return remaining || deferred.resolveWith(resolveContexts, resolveValues), deferred.promise();
        }
    });
    var readyList;
    jQuery.fn.ready = function(fn) {
        return jQuery.ready.promise().done(fn), this;
    }, jQuery.extend({
        isReady:!1,
        readyWait:1,
        holdReady:function(hold) {
            hold ? jQuery.readyWait++ :jQuery.ready(!0);
        },
        ready:function(wait) {
            if (wait === !0 ? !--jQuery.readyWait :!jQuery.isReady) {
                if (!document.body) return setTimeout(jQuery.ready);
                jQuery.isReady = !0, wait !== !0 && --jQuery.readyWait > 0 || (readyList.resolveWith(document, [ jQuery ]), 
                jQuery.fn.trigger && jQuery(document).trigger("ready").off("ready"));
            }
        }
    }), jQuery.ready.promise = function(obj) {
        if (!readyList) if (readyList = jQuery.Deferred(), "complete" === document.readyState) setTimeout(jQuery.ready); else if (document.addEventListener) document.addEventListener("DOMContentLoaded", completed, !1), 
        window.addEventListener("load", completed, !1); else {
            document.attachEvent("onreadystatechange", completed), window.attachEvent("onload", completed);
            var top = !1;
            try {
                top = null == window.frameElement && document.documentElement;
            } catch (e) {}
            top && top.doScroll && !function doScrollCheck() {
                if (!jQuery.isReady) {
                    try {
                        top.doScroll("left");
                    } catch (e) {
                        return setTimeout(doScrollCheck, 50);
                    }
                    detach(), jQuery.ready();
                }
            }();
        }
        return readyList.promise(obj);
    };
    var i, strundefined = "undefined";
    for (i in jQuery(support)) break;
    support.ownLast = "0" !== i, support.inlineBlockNeedsLayout = !1, jQuery(function() {
        var container, div, body = document.getElementsByTagName("body")[0];
        body && (container = document.createElement("div"), container.style.cssText = "border:0;width:0;height:0;position:absolute;top:0;left:-9999px;margin-top:1px", 
        div = document.createElement("div"), body.appendChild(container).appendChild(div), 
        typeof div.style.zoom !== strundefined && (div.style.cssText = "border:0;margin:0;width:1px;padding:1px;display:inline;zoom:1", 
        (support.inlineBlockNeedsLayout = 3 === div.offsetWidth) && (body.style.zoom = 1)), 
        body.removeChild(container), container = div = null);
    }), function() {
        var div = document.createElement("div");
        if (null == support.deleteExpando) {
            support.deleteExpando = !0;
            try {
                delete div.test;
            } catch (e) {
                support.deleteExpando = !1;
            }
        }
        div = null;
    }(), jQuery.acceptData = function(elem) {
        var noData = jQuery.noData[(elem.nodeName + " ").toLowerCase()], nodeType = +elem.nodeType || 1;
        return 1 !== nodeType && 9 !== nodeType ? !1 :!noData || noData !== !0 && elem.getAttribute("classid") === noData;
    };
    var rbrace = /^(?:\{[\w\W]*\}|\[[\w\W]*\])$/, rmultiDash = /([A-Z])/g;
    jQuery.extend({
        cache:{},
        noData:{
            "applet ":!0,
            "embed ":!0,
            "object ":"clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"
        },
        hasData:function(elem) {
            return elem = elem.nodeType ? jQuery.cache[elem[jQuery.expando]] :elem[jQuery.expando], 
            !!elem && !isEmptyDataObject(elem);
        },
        data:function(elem, name, data) {
            return internalData(elem, name, data);
        },
        removeData:function(elem, name) {
            return internalRemoveData(elem, name);
        },
        _data:function(elem, name, data) {
            return internalData(elem, name, data, !0);
        },
        _removeData:function(elem, name) {
            return internalRemoveData(elem, name, !0);
        }
    }), jQuery.fn.extend({
        data:function(key, value) {
            var i, name, data, elem = this[0], attrs = elem && elem.attributes;
            if (void 0 === key) {
                if (this.length && (data = jQuery.data(elem), 1 === elem.nodeType && !jQuery._data(elem, "parsedAttrs"))) {
                    for (i = attrs.length; i--; ) name = attrs[i].name, 0 === name.indexOf("data-") && (name = jQuery.camelCase(name.slice(5)), 
                    dataAttr(elem, name, data[name]));
                    jQuery._data(elem, "parsedAttrs", !0);
                }
                return data;
            }
            return "object" == typeof key ? this.each(function() {
                jQuery.data(this, key);
            }) :arguments.length > 1 ? this.each(function() {
                jQuery.data(this, key, value);
            }) :elem ? dataAttr(elem, key, jQuery.data(elem, key)) :void 0;
        },
        removeData:function(key) {
            return this.each(function() {
                jQuery.removeData(this, key);
            });
        }
    }), jQuery.extend({
        queue:function(elem, type, data) {
            var queue;
            return elem ? (type = (type || "fx") + "queue", queue = jQuery._data(elem, type), 
            data && (!queue || jQuery.isArray(data) ? queue = jQuery._data(elem, type, jQuery.makeArray(data)) :queue.push(data)), 
            queue || []) :void 0;
        },
        dequeue:function(elem, type) {
            type = type || "fx";
            var queue = jQuery.queue(elem, type), startLength = queue.length, fn = queue.shift(), hooks = jQuery._queueHooks(elem, type), next = function() {
                jQuery.dequeue(elem, type);
            };
            "inprogress" === fn && (fn = queue.shift(), startLength--), fn && ("fx" === type && queue.unshift("inprogress"), 
            delete hooks.stop, fn.call(elem, next, hooks)), !startLength && hooks && hooks.empty.fire();
        },
        _queueHooks:function(elem, type) {
            var key = type + "queueHooks";
            return jQuery._data(elem, key) || jQuery._data(elem, key, {
                empty:jQuery.Callbacks("once memory").add(function() {
                    jQuery._removeData(elem, type + "queue"), jQuery._removeData(elem, key);
                })
            });
        }
    }), jQuery.fn.extend({
        queue:function(type, data) {
            var setter = 2;
            return "string" != typeof type && (data = type, type = "fx", setter--), arguments.length < setter ? jQuery.queue(this[0], type) :void 0 === data ? this :this.each(function() {
                var queue = jQuery.queue(this, type, data);
                jQuery._queueHooks(this, type), "fx" === type && "inprogress" !== queue[0] && jQuery.dequeue(this, type);
            });
        },
        dequeue:function(type) {
            return this.each(function() {
                jQuery.dequeue(this, type);
            });
        },
        clearQueue:function(type) {
            return this.queue(type || "fx", []);
        },
        promise:function(type, obj) {
            var tmp, count = 1, defer = jQuery.Deferred(), elements = this, i = this.length, resolve = function() {
                --count || defer.resolveWith(elements, [ elements ]);
            };
            for ("string" != typeof type && (obj = type, type = void 0), type = type || "fx"; i--; ) tmp = jQuery._data(elements[i], type + "queueHooks"), 
            tmp && tmp.empty && (count++, tmp.empty.add(resolve));
            return resolve(), defer.promise(obj);
        }
    });
    var pnum = /[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source, cssExpand = [ "Top", "Right", "Bottom", "Left" ], isHidden = function(elem, el) {
        return elem = el || elem, "none" === jQuery.css(elem, "display") || !jQuery.contains(elem.ownerDocument, elem);
    }, access = jQuery.access = function(elems, fn, key, value, chainable, emptyGet, raw) {
        var i = 0, length = elems.length, bulk = null == key;
        if ("object" === jQuery.type(key)) {
            chainable = !0;
            for (i in key) jQuery.access(elems, fn, i, key[i], !0, emptyGet, raw);
        } else if (void 0 !== value && (chainable = !0, jQuery.isFunction(value) || (raw = !0), 
        bulk && (raw ? (fn.call(elems, value), fn = null) :(bulk = fn, fn = function(elem, key, value) {
            return bulk.call(jQuery(elem), value);
        })), fn)) for (;length > i; i++) fn(elems[i], key, raw ? value :value.call(elems[i], i, fn(elems[i], key)));
        return chainable ? elems :bulk ? fn.call(elems) :length ? fn(elems[0], key) :emptyGet;
    }, rcheckableType = /^(?:checkbox|radio)$/i;
    !function() {
        var fragment = document.createDocumentFragment(), div = document.createElement("div"), input = document.createElement("input");
        if (div.setAttribute("className", "t"), div.innerHTML = "  <link/><table></table><a href='/a'>a</a>", 
        support.leadingWhitespace = 3 === div.firstChild.nodeType, support.tbody = !div.getElementsByTagName("tbody").length, 
        support.htmlSerialize = !!div.getElementsByTagName("link").length, support.html5Clone = "<:nav></:nav>" !== document.createElement("nav").cloneNode(!0).outerHTML, 
        input.type = "checkbox", input.checked = !0, fragment.appendChild(input), support.appendChecked = input.checked, 
        div.innerHTML = "<textarea>x</textarea>", support.noCloneChecked = !!div.cloneNode(!0).lastChild.defaultValue, 
        fragment.appendChild(div), div.innerHTML = "<input type='radio' checked='checked' name='t'/>", 
        support.checkClone = div.cloneNode(!0).cloneNode(!0).lastChild.checked, support.noCloneEvent = !0, 
        div.attachEvent && (div.attachEvent("onclick", function() {
            support.noCloneEvent = !1;
        }), div.cloneNode(!0).click()), null == support.deleteExpando) {
            support.deleteExpando = !0;
            try {
                delete div.test;
            } catch (e) {
                support.deleteExpando = !1;
            }
        }
        fragment = div = input = null;
    }(), function() {
        var i, eventName, div = document.createElement("div");
        for (i in {
            submit:!0,
            change:!0,
            focusin:!0
        }) eventName = "on" + i, (support[i + "Bubbles"] = eventName in window) || (div.setAttribute(eventName, "t"), 
        support[i + "Bubbles"] = div.attributes[eventName].expando === !1);
        div = null;
    }();
    var rformElems = /^(?:input|select|textarea)$/i, rkeyEvent = /^key/, rmouseEvent = /^(?:mouse|contextmenu)|click/, rfocusMorph = /^(?:focusinfocus|focusoutblur)$/, rtypenamespace = /^([^.]*)(?:\.(.+)|)$/;
    jQuery.event = {
        global:{},
        add:function(elem, types, handler, data, selector) {
            var tmp, events, t, handleObjIn, special, eventHandle, handleObj, handlers, type, namespaces, origType, elemData = jQuery._data(elem);
            if (elemData) {
                for (handler.handler && (handleObjIn = handler, handler = handleObjIn.handler, selector = handleObjIn.selector), 
                handler.guid || (handler.guid = jQuery.guid++), (events = elemData.events) || (events = elemData.events = {}), 
                (eventHandle = elemData.handle) || (eventHandle = elemData.handle = function(e) {
                    return typeof jQuery === strundefined || e && jQuery.event.triggered === e.type ? void 0 :jQuery.event.dispatch.apply(eventHandle.elem, arguments);
                }, eventHandle.elem = elem), types = (types || "").match(rnotwhite) || [ "" ], t = types.length; t--; ) tmp = rtypenamespace.exec(types[t]) || [], 
                type = origType = tmp[1], namespaces = (tmp[2] || "").split(".").sort(), type && (special = jQuery.event.special[type] || {}, 
                type = (selector ? special.delegateType :special.bindType) || type, special = jQuery.event.special[type] || {}, 
                handleObj = jQuery.extend({
                    type:type,
                    origType:origType,
                    data:data,
                    handler:handler,
                    guid:handler.guid,
                    selector:selector,
                    needsContext:selector && jQuery.expr.match.needsContext.test(selector),
                    namespace:namespaces.join(".")
                }, handleObjIn), (handlers = events[type]) || (handlers = events[type] = [], handlers.delegateCount = 0, 
                special.setup && special.setup.call(elem, data, namespaces, eventHandle) !== !1 || (elem.addEventListener ? elem.addEventListener(type, eventHandle, !1) :elem.attachEvent && elem.attachEvent("on" + type, eventHandle))), 
                special.add && (special.add.call(elem, handleObj), handleObj.handler.guid || (handleObj.handler.guid = handler.guid)), 
                selector ? handlers.splice(handlers.delegateCount++, 0, handleObj) :handlers.push(handleObj), 
                jQuery.event.global[type] = !0);
                elem = null;
            }
        },
        remove:function(elem, types, handler, selector, mappedTypes) {
            var j, handleObj, tmp, origCount, t, events, special, handlers, type, namespaces, origType, elemData = jQuery.hasData(elem) && jQuery._data(elem);
            if (elemData && (events = elemData.events)) {
                for (types = (types || "").match(rnotwhite) || [ "" ], t = types.length; t--; ) if (tmp = rtypenamespace.exec(types[t]) || [], 
                type = origType = tmp[1], namespaces = (tmp[2] || "").split(".").sort(), type) {
                    for (special = jQuery.event.special[type] || {}, type = (selector ? special.delegateType :special.bindType) || type, 
                    handlers = events[type] || [], tmp = tmp[2] && new RegExp("(^|\\.)" + namespaces.join("\\.(?:.*\\.|)") + "(\\.|$)"), 
                    origCount = j = handlers.length; j--; ) handleObj = handlers[j], !mappedTypes && origType !== handleObj.origType || handler && handler.guid !== handleObj.guid || tmp && !tmp.test(handleObj.namespace) || selector && selector !== handleObj.selector && ("**" !== selector || !handleObj.selector) || (handlers.splice(j, 1), 
                    handleObj.selector && handlers.delegateCount--, special.remove && special.remove.call(elem, handleObj));
                    origCount && !handlers.length && (special.teardown && special.teardown.call(elem, namespaces, elemData.handle) !== !1 || jQuery.removeEvent(elem, type, elemData.handle), 
                    delete events[type]);
                } else for (type in events) jQuery.event.remove(elem, type + types[t], handler, selector, !0);
                jQuery.isEmptyObject(events) && (delete elemData.handle, jQuery._removeData(elem, "events"));
            }
        },
        trigger:function(event, data, elem, onlyHandlers) {
            var handle, ontype, cur, bubbleType, special, tmp, i, eventPath = [ elem || document ], type = hasOwn.call(event, "type") ? event.type :event, namespaces = hasOwn.call(event, "namespace") ? event.namespace.split(".") :[];
            if (cur = tmp = elem = elem || document, 3 !== elem.nodeType && 8 !== elem.nodeType && !rfocusMorph.test(type + jQuery.event.triggered) && (type.indexOf(".") >= 0 && (namespaces = type.split("."), 
            type = namespaces.shift(), namespaces.sort()), ontype = type.indexOf(":") < 0 && "on" + type, 
            event = event[jQuery.expando] ? event :new jQuery.Event(type, "object" == typeof event && event), 
            event.isTrigger = onlyHandlers ? 2 :3, event.namespace = namespaces.join("."), event.namespace_re = event.namespace ? new RegExp("(^|\\.)" + namespaces.join("\\.(?:.*\\.|)") + "(\\.|$)") :null, 
            event.result = void 0, event.target || (event.target = elem), data = null == data ? [ event ] :jQuery.makeArray(data, [ event ]), 
            special = jQuery.event.special[type] || {}, onlyHandlers || !special.trigger || special.trigger.apply(elem, data) !== !1)) {
                if (!onlyHandlers && !special.noBubble && !jQuery.isWindow(elem)) {
                    for (bubbleType = special.delegateType || type, rfocusMorph.test(bubbleType + type) || (cur = cur.parentNode); cur; cur = cur.parentNode) eventPath.push(cur), 
                    tmp = cur;
                    tmp === (elem.ownerDocument || document) && eventPath.push(tmp.defaultView || tmp.parentWindow || window);
                }
                for (i = 0; (cur = eventPath[i++]) && !event.isPropagationStopped(); ) event.type = i > 1 ? bubbleType :special.bindType || type, 
                handle = (jQuery._data(cur, "events") || {})[event.type] && jQuery._data(cur, "handle"), 
                handle && handle.apply(cur, data), handle = ontype && cur[ontype], handle && handle.apply && jQuery.acceptData(cur) && (event.result = handle.apply(cur, data), 
                event.result === !1 && event.preventDefault());
                if (event.type = type, !onlyHandlers && !event.isDefaultPrevented() && (!special._default || special._default.apply(eventPath.pop(), data) === !1) && jQuery.acceptData(elem) && ontype && elem[type] && !jQuery.isWindow(elem)) {
                    tmp = elem[ontype], tmp && (elem[ontype] = null), jQuery.event.triggered = type;
                    try {
                        elem[type]();
                    } catch (e) {}
                    jQuery.event.triggered = void 0, tmp && (elem[ontype] = tmp);
                }
                return event.result;
            }
        },
        dispatch:function(event) {
            event = jQuery.event.fix(event);
            var i, ret, handleObj, matched, j, handlerQueue = [], args = slice.call(arguments), handlers = (jQuery._data(this, "events") || {})[event.type] || [], special = jQuery.event.special[event.type] || {};
            if (args[0] = event, event.delegateTarget = this, !special.preDispatch || special.preDispatch.call(this, event) !== !1) {
                for (handlerQueue = jQuery.event.handlers.call(this, event, handlers), i = 0; (matched = handlerQueue[i++]) && !event.isPropagationStopped(); ) for (event.currentTarget = matched.elem, 
                j = 0; (handleObj = matched.handlers[j++]) && !event.isImmediatePropagationStopped(); ) (!event.namespace_re || event.namespace_re.test(handleObj.namespace)) && (event.handleObj = handleObj, 
                event.data = handleObj.data, ret = ((jQuery.event.special[handleObj.origType] || {}).handle || handleObj.handler).apply(matched.elem, args), 
                void 0 !== ret && (event.result = ret) === !1 && (event.preventDefault(), event.stopPropagation()));
                return special.postDispatch && special.postDispatch.call(this, event), event.result;
            }
        },
        handlers:function(event, handlers) {
            var sel, handleObj, matches, i, handlerQueue = [], delegateCount = handlers.delegateCount, cur = event.target;
            if (delegateCount && cur.nodeType && (!event.button || "click" !== event.type)) for (;cur != this; cur = cur.parentNode || this) if (1 === cur.nodeType && (cur.disabled !== !0 || "click" !== event.type)) {
                for (matches = [], i = 0; delegateCount > i; i++) handleObj = handlers[i], sel = handleObj.selector + " ", 
                void 0 === matches[sel] && (matches[sel] = handleObj.needsContext ? jQuery(sel, this).index(cur) >= 0 :jQuery.find(sel, this, null, [ cur ]).length), 
                matches[sel] && matches.push(handleObj);
                matches.length && handlerQueue.push({
                    elem:cur,
                    handlers:matches
                });
            }
            return delegateCount < handlers.length && handlerQueue.push({
                elem:this,
                handlers:handlers.slice(delegateCount)
            }), handlerQueue;
        },
        fix:function(event) {
            if (event[jQuery.expando]) return event;
            var i, prop, copy, type = event.type, originalEvent = event, fixHook = this.fixHooks[type];
            for (fixHook || (this.fixHooks[type] = fixHook = rmouseEvent.test(type) ? this.mouseHooks :rkeyEvent.test(type) ? this.keyHooks :{}), 
            copy = fixHook.props ? this.props.concat(fixHook.props) :this.props, event = new jQuery.Event(originalEvent), 
            i = copy.length; i--; ) prop = copy[i], event[prop] = originalEvent[prop];
            return event.target || (event.target = originalEvent.srcElement || document), 3 === event.target.nodeType && (event.target = event.target.parentNode), 
            event.metaKey = !!event.metaKey, fixHook.filter ? fixHook.filter(event, originalEvent) :event;
        },
        props:"altKey bubbles cancelable ctrlKey currentTarget eventPhase metaKey relatedTarget shiftKey target timeStamp view which".split(" "),
        fixHooks:{},
        keyHooks:{
            props:"char charCode key keyCode".split(" "),
            filter:function(event, original) {
                return null == event.which && (event.which = null != original.charCode ? original.charCode :original.keyCode), 
                event;
            }
        },
        mouseHooks:{
            props:"button buttons clientX clientY fromElement offsetX offsetY pageX pageY screenX screenY toElement".split(" "),
            filter:function(event, original) {
                var body, eventDoc, doc, button = original.button, fromElement = original.fromElement;
                return null == event.pageX && null != original.clientX && (eventDoc = event.target.ownerDocument || document, 
                doc = eventDoc.documentElement, body = eventDoc.body, event.pageX = original.clientX + (doc && doc.scrollLeft || body && body.scrollLeft || 0) - (doc && doc.clientLeft || body && body.clientLeft || 0), 
                event.pageY = original.clientY + (doc && doc.scrollTop || body && body.scrollTop || 0) - (doc && doc.clientTop || body && body.clientTop || 0)), 
                !event.relatedTarget && fromElement && (event.relatedTarget = fromElement === event.target ? original.toElement :fromElement), 
                event.which || void 0 === button || (event.which = 1 & button ? 1 :2 & button ? 3 :4 & button ? 2 :0), 
                event;
            }
        },
        special:{
            load:{
                noBubble:!0
            },
            focus:{
                trigger:function() {
                    if (this !== safeActiveElement() && this.focus) try {
                        return this.focus(), !1;
                    } catch (e) {}
                },
                delegateType:"focusin"
            },
            blur:{
                trigger:function() {
                    return this === safeActiveElement() && this.blur ? (this.blur(), !1) :void 0;
                },
                delegateType:"focusout"
            },
            click:{
                trigger:function() {
                    return jQuery.nodeName(this, "input") && "checkbox" === this.type && this.click ? (this.click(), 
                    !1) :void 0;
                },
                _default:function(event) {
                    return jQuery.nodeName(event.target, "a");
                }
            },
            beforeunload:{
                postDispatch:function(event) {
                    void 0 !== event.result && (event.originalEvent.returnValue = event.result);
                }
            }
        },
        simulate:function(type, elem, event, bubble) {
            var e = jQuery.extend(new jQuery.Event(), event, {
                type:type,
                isSimulated:!0,
                originalEvent:{}
            });
            bubble ? jQuery.event.trigger(e, null, elem) :jQuery.event.dispatch.call(elem, e), 
            e.isDefaultPrevented() && event.preventDefault();
        }
    }, jQuery.removeEvent = document.removeEventListener ? function(elem, type, handle) {
        elem.removeEventListener && elem.removeEventListener(type, handle, !1);
    } :function(elem, type, handle) {
        var name = "on" + type;
        elem.detachEvent && (typeof elem[name] === strundefined && (elem[name] = null), 
        elem.detachEvent(name, handle));
    }, jQuery.Event = function(src, props) {
        return this instanceof jQuery.Event ? (src && src.type ? (this.originalEvent = src, 
        this.type = src.type, this.isDefaultPrevented = src.defaultPrevented || void 0 === src.defaultPrevented && (src.returnValue === !1 || src.getPreventDefault && src.getPreventDefault()) ? returnTrue :returnFalse) :this.type = src, 
        props && jQuery.extend(this, props), this.timeStamp = src && src.timeStamp || jQuery.now(), 
        void (this[jQuery.expando] = !0)) :new jQuery.Event(src, props);
    }, jQuery.Event.prototype = {
        isDefaultPrevented:returnFalse,
        isPropagationStopped:returnFalse,
        isImmediatePropagationStopped:returnFalse,
        preventDefault:function() {
            var e = this.originalEvent;
            this.isDefaultPrevented = returnTrue, e && (e.preventDefault ? e.preventDefault() :e.returnValue = !1);
        },
        stopPropagation:function() {
            var e = this.originalEvent;
            this.isPropagationStopped = returnTrue, e && (e.stopPropagation && e.stopPropagation(), 
            e.cancelBubble = !0);
        },
        stopImmediatePropagation:function() {
            this.isImmediatePropagationStopped = returnTrue, this.stopPropagation();
        }
    }, jQuery.each({
        mouseenter:"mouseover",
        mouseleave:"mouseout"
    }, function(orig, fix) {
        jQuery.event.special[orig] = {
            delegateType:fix,
            bindType:fix,
            handle:function(event) {
                var ret, target = this, related = event.relatedTarget, handleObj = event.handleObj;
                return (!related || related !== target && !jQuery.contains(target, related)) && (event.type = handleObj.origType, 
                ret = handleObj.handler.apply(this, arguments), event.type = fix), ret;
            }
        };
    }), support.submitBubbles || (jQuery.event.special.submit = {
        setup:function() {
            return jQuery.nodeName(this, "form") ? !1 :void jQuery.event.add(this, "click._submit keypress._submit", function(e) {
                var elem = e.target, form = jQuery.nodeName(elem, "input") || jQuery.nodeName(elem, "button") ? elem.form :void 0;
                form && !jQuery._data(form, "submitBubbles") && (jQuery.event.add(form, "submit._submit", function(event) {
                    event._submit_bubble = !0;
                }), jQuery._data(form, "submitBubbles", !0));
            });
        },
        postDispatch:function(event) {
            event._submit_bubble && (delete event._submit_bubble, this.parentNode && !event.isTrigger && jQuery.event.simulate("submit", this.parentNode, event, !0));
        },
        teardown:function() {
            return jQuery.nodeName(this, "form") ? !1 :void jQuery.event.remove(this, "._submit");
        }
    }), support.changeBubbles || (jQuery.event.special.change = {
        setup:function() {
            return rformElems.test(this.nodeName) ? (("checkbox" === this.type || "radio" === this.type) && (jQuery.event.add(this, "propertychange._change", function(event) {
                "checked" === event.originalEvent.propertyName && (this._just_changed = !0);
            }), jQuery.event.add(this, "click._change", function(event) {
                this._just_changed && !event.isTrigger && (this._just_changed = !1), jQuery.event.simulate("change", this, event, !0);
            })), !1) :void jQuery.event.add(this, "beforeactivate._change", function(e) {
                var elem = e.target;
                rformElems.test(elem.nodeName) && !jQuery._data(elem, "changeBubbles") && (jQuery.event.add(elem, "change._change", function(event) {
                    !this.parentNode || event.isSimulated || event.isTrigger || jQuery.event.simulate("change", this.parentNode, event, !0);
                }), jQuery._data(elem, "changeBubbles", !0));
            });
        },
        handle:function(event) {
            var elem = event.target;
            return this !== elem || event.isSimulated || event.isTrigger || "radio" !== elem.type && "checkbox" !== elem.type ? event.handleObj.handler.apply(this, arguments) :void 0;
        },
        teardown:function() {
            return jQuery.event.remove(this, "._change"), !rformElems.test(this.nodeName);
        }
    }), support.focusinBubbles || jQuery.each({
        focus:"focusin",
        blur:"focusout"
    }, function(orig, fix) {
        var handler = function(event) {
            jQuery.event.simulate(fix, event.target, jQuery.event.fix(event), !0);
        };
        jQuery.event.special[fix] = {
            setup:function() {
                var doc = this.ownerDocument || this, attaches = jQuery._data(doc, fix);
                attaches || doc.addEventListener(orig, handler, !0), jQuery._data(doc, fix, (attaches || 0) + 1);
            },
            teardown:function() {
                var doc = this.ownerDocument || this, attaches = jQuery._data(doc, fix) - 1;
                attaches ? jQuery._data(doc, fix, attaches) :(doc.removeEventListener(orig, handler, !0), 
                jQuery._removeData(doc, fix));
            }
        };
    }), jQuery.fn.extend({
        on:function(types, selector, data, fn, one) {
            var type, origFn;
            if ("object" == typeof types) {
                "string" != typeof selector && (data = data || selector, selector = void 0);
                for (type in types) this.on(type, selector, data, types[type], one);
                return this;
            }
            if (null == data && null == fn ? (fn = selector, data = selector = void 0) :null == fn && ("string" == typeof selector ? (fn = data, 
            data = void 0) :(fn = data, data = selector, selector = void 0)), fn === !1) fn = returnFalse; else if (!fn) return this;
            return 1 === one && (origFn = fn, fn = function(event) {
                return jQuery().off(event), origFn.apply(this, arguments);
            }, fn.guid = origFn.guid || (origFn.guid = jQuery.guid++)), this.each(function() {
                jQuery.event.add(this, types, fn, data, selector);
            });
        },
        one:function(types, selector, data, fn) {
            return this.on(types, selector, data, fn, 1);
        },
        off:function(types, selector, fn) {
            var handleObj, type;
            if (types && types.preventDefault && types.handleObj) return handleObj = types.handleObj, 
            jQuery(types.delegateTarget).off(handleObj.namespace ? handleObj.origType + "." + handleObj.namespace :handleObj.origType, handleObj.selector, handleObj.handler), 
            this;
            if ("object" == typeof types) {
                for (type in types) this.off(type, selector, types[type]);
                return this;
            }
            return (selector === !1 || "function" == typeof selector) && (fn = selector, selector = void 0), 
            fn === !1 && (fn = returnFalse), this.each(function() {
                jQuery.event.remove(this, types, fn, selector);
            });
        },
        trigger:function(type, data) {
            return this.each(function() {
                jQuery.event.trigger(type, data, this);
            });
        },
        triggerHandler:function(type, data) {
            var elem = this[0];
            return elem ? jQuery.event.trigger(type, data, elem, !0) :void 0;
        }
    });
    var nodeNames = "abbr|article|aside|audio|bdi|canvas|data|datalist|details|figcaption|figure|footer|header|hgroup|mark|meter|nav|output|progress|section|summary|time|video", rinlinejQuery = / jQuery\d+="(?:null|\d+)"/g, rnoshimcache = new RegExp("<(?:" + nodeNames + ")[\\s/>]", "i"), rleadingWhitespace = /^\s+/, rxhtmlTag = /<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi, rtagName = /<([\w:]+)/, rtbody = /<tbody/i, rhtml = /<|&#?\w+;/, rnoInnerhtml = /<(?:script|style|link)/i, rchecked = /checked\s*(?:[^=]|=\s*.checked.)/i, rscriptType = /^$|\/(?:java|ecma)script/i, rscriptTypeMasked = /^true\/(.*)/, rcleanScript = /^\s*<!(?:\[CDATA\[|--)|(?:\]\]|--)>\s*$/g, wrapMap = {
        option:[ 1, "<select multiple='multiple'>", "</select>" ],
        legend:[ 1, "<fieldset>", "</fieldset>" ],
        area:[ 1, "<map>", "</map>" ],
        param:[ 1, "<object>", "</object>" ],
        thead:[ 1, "<table>", "</table>" ],
        tr:[ 2, "<table><tbody>", "</tbody></table>" ],
        col:[ 2, "<table><tbody></tbody><colgroup>", "</colgroup></table>" ],
        td:[ 3, "<table><tbody><tr>", "</tr></tbody></table>" ],
        _default:support.htmlSerialize ? [ 0, "", "" ] :[ 1, "X<div>", "</div>" ]
    }, safeFragment = createSafeFragment(document), fragmentDiv = safeFragment.appendChild(document.createElement("div"));
    wrapMap.optgroup = wrapMap.option, wrapMap.tbody = wrapMap.tfoot = wrapMap.colgroup = wrapMap.caption = wrapMap.thead, 
    wrapMap.th = wrapMap.td, jQuery.extend({
        clone:function(elem, dataAndEvents, deepDataAndEvents) {
            var destElements, node, clone, i, srcElements, inPage = jQuery.contains(elem.ownerDocument, elem);
            if (support.html5Clone || jQuery.isXMLDoc(elem) || !rnoshimcache.test("<" + elem.nodeName + ">") ? clone = elem.cloneNode(!0) :(fragmentDiv.innerHTML = elem.outerHTML, 
            fragmentDiv.removeChild(clone = fragmentDiv.firstChild)), !(support.noCloneEvent && support.noCloneChecked || 1 !== elem.nodeType && 11 !== elem.nodeType || jQuery.isXMLDoc(elem))) for (destElements = getAll(clone), 
            srcElements = getAll(elem), i = 0; null != (node = srcElements[i]); ++i) destElements[i] && fixCloneNodeIssues(node, destElements[i]);
            if (dataAndEvents) if (deepDataAndEvents) for (srcElements = srcElements || getAll(elem), 
            destElements = destElements || getAll(clone), i = 0; null != (node = srcElements[i]); i++) cloneCopyEvent(node, destElements[i]); else cloneCopyEvent(elem, clone);
            return destElements = getAll(clone, "script"), destElements.length > 0 && setGlobalEval(destElements, !inPage && getAll(elem, "script")), 
            destElements = srcElements = node = null, clone;
        },
        buildFragment:function(elems, context, scripts, selection) {
            for (var j, elem, contains, tmp, tag, tbody, wrap, l = elems.length, safe = createSafeFragment(context), nodes = [], i = 0; l > i; i++) if (elem = elems[i], 
            elem || 0 === elem) if ("object" === jQuery.type(elem)) jQuery.merge(nodes, elem.nodeType ? [ elem ] :elem); else if (rhtml.test(elem)) {
                for (tmp = tmp || safe.appendChild(context.createElement("div")), tag = (rtagName.exec(elem) || [ "", "" ])[1].toLowerCase(), 
                wrap = wrapMap[tag] || wrapMap._default, tmp.innerHTML = wrap[1] + elem.replace(rxhtmlTag, "<$1></$2>") + wrap[2], 
                j = wrap[0]; j--; ) tmp = tmp.lastChild;
                if (!support.leadingWhitespace && rleadingWhitespace.test(elem) && nodes.push(context.createTextNode(rleadingWhitespace.exec(elem)[0])), 
                !support.tbody) for (elem = "table" !== tag || rtbody.test(elem) ? "<table>" !== wrap[1] || rtbody.test(elem) ? 0 :tmp :tmp.firstChild, 
                j = elem && elem.childNodes.length; j--; ) jQuery.nodeName(tbody = elem.childNodes[j], "tbody") && !tbody.childNodes.length && elem.removeChild(tbody);
                for (jQuery.merge(nodes, tmp.childNodes), tmp.textContent = ""; tmp.firstChild; ) tmp.removeChild(tmp.firstChild);
                tmp = safe.lastChild;
            } else nodes.push(context.createTextNode(elem));
            for (tmp && safe.removeChild(tmp), support.appendChecked || jQuery.grep(getAll(nodes, "input"), fixDefaultChecked), 
            i = 0; elem = nodes[i++]; ) if ((!selection || -1 === jQuery.inArray(elem, selection)) && (contains = jQuery.contains(elem.ownerDocument, elem), 
            tmp = getAll(safe.appendChild(elem), "script"), contains && setGlobalEval(tmp), 
            scripts)) for (j = 0; elem = tmp[j++]; ) rscriptType.test(elem.type || "") && scripts.push(elem);
            return tmp = null, safe;
        },
        cleanData:function(elems, acceptData) {
            for (var elem, type, id, data, i = 0, internalKey = jQuery.expando, cache = jQuery.cache, deleteExpando = support.deleteExpando, special = jQuery.event.special; null != (elem = elems[i]); i++) if ((acceptData || jQuery.acceptData(elem)) && (id = elem[internalKey], 
            data = id && cache[id])) {
                if (data.events) for (type in data.events) special[type] ? jQuery.event.remove(elem, type) :jQuery.removeEvent(elem, type, data.handle);
                cache[id] && (delete cache[id], deleteExpando ? delete elem[internalKey] :typeof elem.removeAttribute !== strundefined ? elem.removeAttribute(internalKey) :elem[internalKey] = null, 
                deletedIds.push(id));
            }
        }
    }), jQuery.fn.extend({
        text:function(value) {
            return access(this, function(value) {
                return void 0 === value ? jQuery.text(this) :this.empty().append((this[0] && this[0].ownerDocument || document).createTextNode(value));
            }, null, value, arguments.length);
        },
        append:function() {
            return this.domManip(arguments, function(elem) {
                if (1 === this.nodeType || 11 === this.nodeType || 9 === this.nodeType) {
                    var target = manipulationTarget(this, elem);
                    target.appendChild(elem);
                }
            });
        },
        prepend:function() {
            return this.domManip(arguments, function(elem) {
                if (1 === this.nodeType || 11 === this.nodeType || 9 === this.nodeType) {
                    var target = manipulationTarget(this, elem);
                    target.insertBefore(elem, target.firstChild);
                }
            });
        },
        before:function() {
            return this.domManip(arguments, function(elem) {
                this.parentNode && this.parentNode.insertBefore(elem, this);
            });
        },
        after:function() {
            return this.domManip(arguments, function(elem) {
                this.parentNode && this.parentNode.insertBefore(elem, this.nextSibling);
            });
        },
        remove:function(selector, keepData) {
            for (var elem, elems = selector ? jQuery.filter(selector, this) :this, i = 0; null != (elem = elems[i]); i++) keepData || 1 !== elem.nodeType || jQuery.cleanData(getAll(elem)), 
            elem.parentNode && (keepData && jQuery.contains(elem.ownerDocument, elem) && setGlobalEval(getAll(elem, "script")), 
            elem.parentNode.removeChild(elem));
            return this;
        },
        empty:function() {
            for (var elem, i = 0; null != (elem = this[i]); i++) {
                for (1 === elem.nodeType && jQuery.cleanData(getAll(elem, !1)); elem.firstChild; ) elem.removeChild(elem.firstChild);
                elem.options && jQuery.nodeName(elem, "select") && (elem.options.length = 0);
            }
            return this;
        },
        clone:function(dataAndEvents, deepDataAndEvents) {
            return dataAndEvents = null == dataAndEvents ? !1 :dataAndEvents, deepDataAndEvents = null == deepDataAndEvents ? dataAndEvents :deepDataAndEvents, 
            this.map(function() {
                return jQuery.clone(this, dataAndEvents, deepDataAndEvents);
            });
        },
        html:function(value) {
            return access(this, function(value) {
                var elem = this[0] || {}, i = 0, l = this.length;
                if (void 0 === value) return 1 === elem.nodeType ? elem.innerHTML.replace(rinlinejQuery, "") :void 0;
                if (!("string" != typeof value || rnoInnerhtml.test(value) || !support.htmlSerialize && rnoshimcache.test(value) || !support.leadingWhitespace && rleadingWhitespace.test(value) || wrapMap[(rtagName.exec(value) || [ "", "" ])[1].toLowerCase()])) {
                    value = value.replace(rxhtmlTag, "<$1></$2>");
                    try {
                        for (;l > i; i++) elem = this[i] || {}, 1 === elem.nodeType && (jQuery.cleanData(getAll(elem, !1)), 
                        elem.innerHTML = value);
                        elem = 0;
                    } catch (e) {}
                }
                elem && this.empty().append(value);
            }, null, value, arguments.length);
        },
        replaceWith:function() {
            var arg = arguments[0];
            return this.domManip(arguments, function(elem) {
                arg = this.parentNode, jQuery.cleanData(getAll(this)), arg && arg.replaceChild(elem, this);
            }), arg && (arg.length || arg.nodeType) ? this :this.remove();
        },
        detach:function(selector) {
            return this.remove(selector, !0);
        },
        domManip:function(args, callback) {
            args = concat.apply([], args);
            var first, node, hasScripts, scripts, doc, fragment, i = 0, l = this.length, set = this, iNoClone = l - 1, value = args[0], isFunction = jQuery.isFunction(value);
            if (isFunction || l > 1 && "string" == typeof value && !support.checkClone && rchecked.test(value)) return this.each(function(index) {
                var self = set.eq(index);
                isFunction && (args[0] = value.call(this, index, self.html())), self.domManip(args, callback);
            });
            if (l && (fragment = jQuery.buildFragment(args, this[0].ownerDocument, !1, this), 
            first = fragment.firstChild, 1 === fragment.childNodes.length && (fragment = first), 
            first)) {
                for (scripts = jQuery.map(getAll(fragment, "script"), disableScript), hasScripts = scripts.length; l > i; i++) node = fragment, 
                i !== iNoClone && (node = jQuery.clone(node, !0, !0), hasScripts && jQuery.merge(scripts, getAll(node, "script"))), 
                callback.call(this[i], node, i);
                if (hasScripts) for (doc = scripts[scripts.length - 1].ownerDocument, jQuery.map(scripts, restoreScript), 
                i = 0; hasScripts > i; i++) node = scripts[i], rscriptType.test(node.type || "") && !jQuery._data(node, "globalEval") && jQuery.contains(doc, node) && (node.src ? jQuery._evalUrl && jQuery._evalUrl(node.src) :jQuery.globalEval((node.text || node.textContent || node.innerHTML || "").replace(rcleanScript, "")));
                fragment = first = null;
            }
            return this;
        }
    }), jQuery.each({
        appendTo:"append",
        prependTo:"prepend",
        insertBefore:"before",
        insertAfter:"after",
        replaceAll:"replaceWith"
    }, function(name, original) {
        jQuery.fn[name] = function(selector) {
            for (var elems, i = 0, ret = [], insert = jQuery(selector), last = insert.length - 1; last >= i; i++) elems = i === last ? this :this.clone(!0), 
            jQuery(insert[i])[original](elems), push.apply(ret, elems.get());
            return this.pushStack(ret);
        };
    });
    var iframe, elemdisplay = {};
    !function() {
        var a, shrinkWrapBlocksVal, div = document.createElement("div"), divReset = "-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;padding:0;margin:0;border:0";
        div.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", 
        a = div.getElementsByTagName("a")[0], a.style.cssText = "float:left;opacity:.5", 
        support.opacity = /^0.5/.test(a.style.opacity), support.cssFloat = !!a.style.cssFloat, 
        div.style.backgroundClip = "content-box", div.cloneNode(!0).style.backgroundClip = "", 
        support.clearCloneStyle = "content-box" === div.style.backgroundClip, a = div = null, 
        support.shrinkWrapBlocks = function() {
            var body, container, div, containerStyles;
            if (null == shrinkWrapBlocksVal) {
                if (body = document.getElementsByTagName("body")[0], !body) return;
                containerStyles = "border:0;width:0;height:0;position:absolute;top:0;left:-9999px", 
                container = document.createElement("div"), div = document.createElement("div"), 
                body.appendChild(container).appendChild(div), shrinkWrapBlocksVal = !1, typeof div.style.zoom !== strundefined && (div.style.cssText = divReset + ";width:1px;padding:1px;zoom:1", 
                div.innerHTML = "<div></div>", div.firstChild.style.width = "5px", shrinkWrapBlocksVal = 3 !== div.offsetWidth), 
                body.removeChild(container), body = container = div = null;
            }
            return shrinkWrapBlocksVal;
        };
    }();
    var getStyles, curCSS, rmargin = /^margin/, rnumnonpx = new RegExp("^(" + pnum + ")(?!px)[a-z%]+$", "i"), rposition = /^(top|right|bottom|left)$/;
    window.getComputedStyle ? (getStyles = function(elem) {
        return elem.ownerDocument.defaultView.getComputedStyle(elem, null);
    }, curCSS = function(elem, name, computed) {
        var width, minWidth, maxWidth, ret, style = elem.style;
        return computed = computed || getStyles(elem), ret = computed ? computed.getPropertyValue(name) || computed[name] :void 0, 
        computed && ("" !== ret || jQuery.contains(elem.ownerDocument, elem) || (ret = jQuery.style(elem, name)), 
        rnumnonpx.test(ret) && rmargin.test(name) && (width = style.width, minWidth = style.minWidth, 
        maxWidth = style.maxWidth, style.minWidth = style.maxWidth = style.width = ret, 
        ret = computed.width, style.width = width, style.minWidth = minWidth, style.maxWidth = maxWidth)), 
        void 0 === ret ? ret :ret + "";
    }) :document.documentElement.currentStyle && (getStyles = function(elem) {
        return elem.currentStyle;
    }, curCSS = function(elem, name, computed) {
        var left, rs, rsLeft, ret, style = elem.style;
        return computed = computed || getStyles(elem), ret = computed ? computed[name] :void 0, 
        null == ret && style && style[name] && (ret = style[name]), rnumnonpx.test(ret) && !rposition.test(name) && (left = style.left, 
        rs = elem.runtimeStyle, rsLeft = rs && rs.left, rsLeft && (rs.left = elem.currentStyle.left), 
        style.left = "fontSize" === name ? "1em" :ret, ret = style.pixelLeft + "px", style.left = left, 
        rsLeft && (rs.left = rsLeft)), void 0 === ret ? ret :ret + "" || "auto";
    }), function() {
        function computeStyleTests() {
            var container, div, body = document.getElementsByTagName("body")[0];
            body && (container = document.createElement("div"), div = document.createElement("div"), 
            container.style.cssText = containerStyles, body.appendChild(container).appendChild(div), 
            div.style.cssText = "-webkit-box-sizing:border-box;-moz-box-sizing:border-box;box-sizing:border-box;position:absolute;display:block;padding:1px;border:1px;width:4px;margin-top:1%;top:1%", 
            jQuery.swap(body, null != body.style.zoom ? {
                zoom:1
            } :{}, function() {
                boxSizingVal = 4 === div.offsetWidth;
            }), boxSizingReliableVal = !0, pixelPositionVal = !1, reliableMarginRightVal = !0, 
            window.getComputedStyle && (pixelPositionVal = "1%" !== (window.getComputedStyle(div, null) || {}).top, 
            boxSizingReliableVal = "4px" === (window.getComputedStyle(div, null) || {
                width:"4px"
            }).width), body.removeChild(container), div = body = null);
        }
        var a, reliableHiddenOffsetsVal, boxSizingVal, boxSizingReliableVal, pixelPositionVal, reliableMarginRightVal, div = document.createElement("div"), containerStyles = "border:0;width:0;height:0;position:absolute;top:0;left:-9999px", divReset = "-webkit-box-sizing:content-box;-moz-box-sizing:content-box;box-sizing:content-box;display:block;padding:0;margin:0;border:0";
        div.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", 
        a = div.getElementsByTagName("a")[0], a.style.cssText = "float:left;opacity:.5", 
        support.opacity = /^0.5/.test(a.style.opacity), support.cssFloat = !!a.style.cssFloat, 
        div.style.backgroundClip = "content-box", div.cloneNode(!0).style.backgroundClip = "", 
        support.clearCloneStyle = "content-box" === div.style.backgroundClip, a = div = null, 
        jQuery.extend(support, {
            reliableHiddenOffsets:function() {
                if (null != reliableHiddenOffsetsVal) return reliableHiddenOffsetsVal;
                var container, tds, isSupported, div = document.createElement("div"), body = document.getElementsByTagName("body")[0];
                if (body) return div.setAttribute("className", "t"), div.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", 
                container = document.createElement("div"), container.style.cssText = containerStyles, 
                body.appendChild(container).appendChild(div), div.innerHTML = "<table><tr><td></td><td>t</td></tr></table>", 
                tds = div.getElementsByTagName("td"), tds[0].style.cssText = "padding:0;margin:0;border:0;display:none", 
                isSupported = 0 === tds[0].offsetHeight, tds[0].style.display = "", tds[1].style.display = "none", 
                reliableHiddenOffsetsVal = isSupported && 0 === tds[0].offsetHeight, body.removeChild(container), 
                div = body = null, reliableHiddenOffsetsVal;
            },
            boxSizing:function() {
                return null == boxSizingVal && computeStyleTests(), boxSizingVal;
            },
            boxSizingReliable:function() {
                return null == boxSizingReliableVal && computeStyleTests(), boxSizingReliableVal;
            },
            pixelPosition:function() {
                return null == pixelPositionVal && computeStyleTests(), pixelPositionVal;
            },
            reliableMarginRight:function() {
                var body, container, div, marginDiv;
                if (null == reliableMarginRightVal && window.getComputedStyle) {
                    if (body = document.getElementsByTagName("body")[0], !body) return;
                    container = document.createElement("div"), div = document.createElement("div"), 
                    container.style.cssText = containerStyles, body.appendChild(container).appendChild(div), 
                    marginDiv = div.appendChild(document.createElement("div")), marginDiv.style.cssText = div.style.cssText = divReset, 
                    marginDiv.style.marginRight = marginDiv.style.width = "0", div.style.width = "1px", 
                    reliableMarginRightVal = !parseFloat((window.getComputedStyle(marginDiv, null) || {}).marginRight), 
                    body.removeChild(container);
                }
                return reliableMarginRightVal;
            }
        });
    }(), jQuery.swap = function(elem, options, callback, args) {
        var ret, name, old = {};
        for (name in options) old[name] = elem.style[name], elem.style[name] = options[name];
        ret = callback.apply(elem, args || []);
        for (name in options) elem.style[name] = old[name];
        return ret;
    };
    var ralpha = /alpha\([^)]*\)/i, ropacity = /opacity\s*=\s*([^)]*)/, rdisplayswap = /^(none|table(?!-c[ea]).+)/, rnumsplit = new RegExp("^(" + pnum + ")(.*)$", "i"), rrelNum = new RegExp("^([+-])=(" + pnum + ")", "i"), cssShow = {
        position:"absolute",
        visibility:"hidden",
        display:"block"
    }, cssNormalTransform = {
        letterSpacing:0,
        fontWeight:400
    }, cssPrefixes = [ "Webkit", "O", "Moz", "ms" ];
    jQuery.extend({
        cssHooks:{
            opacity:{
                get:function(elem, computed) {
                    if (computed) {
                        var ret = curCSS(elem, "opacity");
                        return "" === ret ? "1" :ret;
                    }
                }
            }
        },
        cssNumber:{
            columnCount:!0,
            fillOpacity:!0,
            fontWeight:!0,
            lineHeight:!0,
            opacity:!0,
            order:!0,
            orphans:!0,
            widows:!0,
            zIndex:!0,
            zoom:!0
        },
        cssProps:{
            "float":support.cssFloat ? "cssFloat" :"styleFloat"
        },
        style:function(elem, name, value, extra) {
            if (elem && 3 !== elem.nodeType && 8 !== elem.nodeType && elem.style) {
                var ret, type, hooks, origName = jQuery.camelCase(name), style = elem.style;
                if (name = jQuery.cssProps[origName] || (jQuery.cssProps[origName] = vendorPropName(style, origName)), 
                hooks = jQuery.cssHooks[name] || jQuery.cssHooks[origName], void 0 === value) return hooks && "get" in hooks && void 0 !== (ret = hooks.get(elem, !1, extra)) ? ret :style[name];
                if (type = typeof value, "string" === type && (ret = rrelNum.exec(value)) && (value = (ret[1] + 1) * ret[2] + parseFloat(jQuery.css(elem, name)), 
                type = "number"), null != value && value === value && ("number" !== type || jQuery.cssNumber[origName] || (value += "px"), 
                support.clearCloneStyle || "" !== value || 0 !== name.indexOf("background") || (style[name] = "inherit"), 
                !(hooks && "set" in hooks && void 0 === (value = hooks.set(elem, value, extra))))) try {
                    style[name] = "", style[name] = value;
                } catch (e) {}
            }
        },
        css:function(elem, name, extra, styles) {
            var num, val, hooks, origName = jQuery.camelCase(name);
            return name = jQuery.cssProps[origName] || (jQuery.cssProps[origName] = vendorPropName(elem.style, origName)), 
            hooks = jQuery.cssHooks[name] || jQuery.cssHooks[origName], hooks && "get" in hooks && (val = hooks.get(elem, !0, extra)), 
            void 0 === val && (val = curCSS(elem, name, styles)), "normal" === val && name in cssNormalTransform && (val = cssNormalTransform[name]), 
            "" === extra || extra ? (num = parseFloat(val), extra === !0 || jQuery.isNumeric(num) ? num || 0 :val) :val;
        }
    }), jQuery.each([ "height", "width" ], function(i, name) {
        jQuery.cssHooks[name] = {
            get:function(elem, computed, extra) {
                return computed ? 0 === elem.offsetWidth && rdisplayswap.test(jQuery.css(elem, "display")) ? jQuery.swap(elem, cssShow, function() {
                    return getWidthOrHeight(elem, name, extra);
                }) :getWidthOrHeight(elem, name, extra) :void 0;
            },
            set:function(elem, value, extra) {
                var styles = extra && getStyles(elem);
                return setPositiveNumber(elem, value, extra ? augmentWidthOrHeight(elem, name, extra, support.boxSizing() && "border-box" === jQuery.css(elem, "boxSizing", !1, styles), styles) :0);
            }
        };
    }), support.opacity || (jQuery.cssHooks.opacity = {
        get:function(elem, computed) {
            return ropacity.test((computed && elem.currentStyle ? elem.currentStyle.filter :elem.style.filter) || "") ? .01 * parseFloat(RegExp.$1) + "" :computed ? "1" :"";
        },
        set:function(elem, value) {
            var style = elem.style, currentStyle = elem.currentStyle, opacity = jQuery.isNumeric(value) ? "alpha(opacity=" + 100 * value + ")" :"", filter = currentStyle && currentStyle.filter || style.filter || "";
            style.zoom = 1, (value >= 1 || "" === value) && "" === jQuery.trim(filter.replace(ralpha, "")) && style.removeAttribute && (style.removeAttribute("filter"), 
            "" === value || currentStyle && !currentStyle.filter) || (style.filter = ralpha.test(filter) ? filter.replace(ralpha, opacity) :filter + " " + opacity);
        }
    }), jQuery.cssHooks.marginRight = addGetHookIf(support.reliableMarginRight, function(elem, computed) {
        return computed ? jQuery.swap(elem, {
            display:"inline-block"
        }, curCSS, [ elem, "marginRight" ]) :void 0;
    }), jQuery.each({
        margin:"",
        padding:"",
        border:"Width"
    }, function(prefix, suffix) {
        jQuery.cssHooks[prefix + suffix] = {
            expand:function(value) {
                for (var i = 0, expanded = {}, parts = "string" == typeof value ? value.split(" ") :[ value ]; 4 > i; i++) expanded[prefix + cssExpand[i] + suffix] = parts[i] || parts[i - 2] || parts[0];
                return expanded;
            }
        }, rmargin.test(prefix) || (jQuery.cssHooks[prefix + suffix].set = setPositiveNumber);
    }), jQuery.fn.extend({
        css:function(name, value) {
            return access(this, function(elem, name, value) {
                var styles, len, map = {}, i = 0;
                if (jQuery.isArray(name)) {
                    for (styles = getStyles(elem), len = name.length; len > i; i++) map[name[i]] = jQuery.css(elem, name[i], !1, styles);
                    return map;
                }
                return void 0 !== value ? jQuery.style(elem, name, value) :jQuery.css(elem, name);
            }, name, value, arguments.length > 1);
        },
        show:function() {
            return showHide(this, !0);
        },
        hide:function() {
            return showHide(this);
        },
        toggle:function(state) {
            return "boolean" == typeof state ? state ? this.show() :this.hide() :this.each(function() {
                isHidden(this) ? jQuery(this).show() :jQuery(this).hide();
            });
        }
    }), jQuery.Tween = Tween, Tween.prototype = {
        constructor:Tween,
        init:function(elem, options, prop, end, easing, unit) {
            this.elem = elem, this.prop = prop, this.easing = easing || "swing", this.options = options, 
            this.start = this.now = this.cur(), this.end = end, this.unit = unit || (jQuery.cssNumber[prop] ? "" :"px");
        },
        cur:function() {
            var hooks = Tween.propHooks[this.prop];
            return hooks && hooks.get ? hooks.get(this) :Tween.propHooks._default.get(this);
        },
        run:function(percent) {
            var eased, hooks = Tween.propHooks[this.prop];
            return this.pos = eased = this.options.duration ? jQuery.easing[this.easing](percent, this.options.duration * percent, 0, 1, this.options.duration) :percent, 
            this.now = (this.end - this.start) * eased + this.start, this.options.step && this.options.step.call(this.elem, this.now, this), 
            hooks && hooks.set ? hooks.set(this) :Tween.propHooks._default.set(this), this;
        }
    }, Tween.prototype.init.prototype = Tween.prototype, Tween.propHooks = {
        _default:{
            get:function(tween) {
                var result;
                return null == tween.elem[tween.prop] || tween.elem.style && null != tween.elem.style[tween.prop] ? (result = jQuery.css(tween.elem, tween.prop, ""), 
                result && "auto" !== result ? result :0) :tween.elem[tween.prop];
            },
            set:function(tween) {
                jQuery.fx.step[tween.prop] ? jQuery.fx.step[tween.prop](tween) :tween.elem.style && (null != tween.elem.style[jQuery.cssProps[tween.prop]] || jQuery.cssHooks[tween.prop]) ? jQuery.style(tween.elem, tween.prop, tween.now + tween.unit) :tween.elem[tween.prop] = tween.now;
            }
        }
    }, Tween.propHooks.scrollTop = Tween.propHooks.scrollLeft = {
        set:function(tween) {
            tween.elem.nodeType && tween.elem.parentNode && (tween.elem[tween.prop] = tween.now);
        }
    }, jQuery.easing = {
        linear:function(p) {
            return p;
        },
        swing:function(p) {
            return .5 - Math.cos(p * Math.PI) / 2;
        }
    }, jQuery.fx = Tween.prototype.init, jQuery.fx.step = {};
    var fxNow, timerId, rfxtypes = /^(?:toggle|show|hide)$/, rfxnum = new RegExp("^(?:([+-])=|)(" + pnum + ")([a-z%]*)$", "i"), rrun = /queueHooks$/, animationPrefilters = [ defaultPrefilter ], tweeners = {
        "*":[ function(prop, value) {
            var tween = this.createTween(prop, value), target = tween.cur(), parts = rfxnum.exec(value), unit = parts && parts[3] || (jQuery.cssNumber[prop] ? "" :"px"), start = (jQuery.cssNumber[prop] || "px" !== unit && +target) && rfxnum.exec(jQuery.css(tween.elem, prop)), scale = 1, maxIterations = 20;
            if (start && start[3] !== unit) {
                unit = unit || start[3], parts = parts || [], start = +target || 1;
                do scale = scale || ".5", start /= scale, jQuery.style(tween.elem, prop, start + unit); while (scale !== (scale = tween.cur() / target) && 1 !== scale && --maxIterations);
            }
            return parts && (start = tween.start = +start || +target || 0, tween.unit = unit, 
            tween.end = parts[1] ? start + (parts[1] + 1) * parts[2] :+parts[2]), tween;
        } ]
    };
    jQuery.Animation = jQuery.extend(Animation, {
        tweener:function(props, callback) {
            jQuery.isFunction(props) ? (callback = props, props = [ "*" ]) :props = props.split(" ");
            for (var prop, index = 0, length = props.length; length > index; index++) prop = props[index], 
            tweeners[prop] = tweeners[prop] || [], tweeners[prop].unshift(callback);
        },
        prefilter:function(callback, prepend) {
            prepend ? animationPrefilters.unshift(callback) :animationPrefilters.push(callback);
        }
    }), jQuery.speed = function(speed, easing, fn) {
        var opt = speed && "object" == typeof speed ? jQuery.extend({}, speed) :{
            complete:fn || !fn && easing || jQuery.isFunction(speed) && speed,
            duration:speed,
            easing:fn && easing || easing && !jQuery.isFunction(easing) && easing
        };
        return opt.duration = jQuery.fx.off ? 0 :"number" == typeof opt.duration ? opt.duration :opt.duration in jQuery.fx.speeds ? jQuery.fx.speeds[opt.duration] :jQuery.fx.speeds._default, 
        (null == opt.queue || opt.queue === !0) && (opt.queue = "fx"), opt.old = opt.complete, 
        opt.complete = function() {
            jQuery.isFunction(opt.old) && opt.old.call(this), opt.queue && jQuery.dequeue(this, opt.queue);
        }, opt;
    }, jQuery.fn.extend({
        fadeTo:function(speed, to, easing, callback) {
            return this.filter(isHidden).css("opacity", 0).show().end().animate({
                opacity:to
            }, speed, easing, callback);
        },
        animate:function(prop, speed, easing, callback) {
            var empty = jQuery.isEmptyObject(prop), optall = jQuery.speed(speed, easing, callback), doAnimation = function() {
                var anim = Animation(this, jQuery.extend({}, prop), optall);
                (empty || jQuery._data(this, "finish")) && anim.stop(!0);
            };
            return doAnimation.finish = doAnimation, empty || optall.queue === !1 ? this.each(doAnimation) :this.queue(optall.queue, doAnimation);
        },
        stop:function(type, clearQueue, gotoEnd) {
            var stopQueue = function(hooks) {
                var stop = hooks.stop;
                delete hooks.stop, stop(gotoEnd);
            };
            return "string" != typeof type && (gotoEnd = clearQueue, clearQueue = type, type = void 0), 
            clearQueue && type !== !1 && this.queue(type || "fx", []), this.each(function() {
                var dequeue = !0, index = null != type && type + "queueHooks", timers = jQuery.timers, data = jQuery._data(this);
                if (index) data[index] && data[index].stop && stopQueue(data[index]); else for (index in data) data[index] && data[index].stop && rrun.test(index) && stopQueue(data[index]);
                for (index = timers.length; index--; ) timers[index].elem !== this || null != type && timers[index].queue !== type || (timers[index].anim.stop(gotoEnd), 
                dequeue = !1, timers.splice(index, 1));
                (dequeue || !gotoEnd) && jQuery.dequeue(this, type);
            });
        },
        finish:function(type) {
            return type !== !1 && (type = type || "fx"), this.each(function() {
                var index, data = jQuery._data(this), queue = data[type + "queue"], hooks = data[type + "queueHooks"], timers = jQuery.timers, length = queue ? queue.length :0;
                for (data.finish = !0, jQuery.queue(this, type, []), hooks && hooks.stop && hooks.stop.call(this, !0), 
                index = timers.length; index--; ) timers[index].elem === this && timers[index].queue === type && (timers[index].anim.stop(!0), 
                timers.splice(index, 1));
                for (index = 0; length > index; index++) queue[index] && queue[index].finish && queue[index].finish.call(this);
                delete data.finish;
            });
        }
    }), jQuery.each([ "toggle", "show", "hide" ], function(i, name) {
        var cssFn = jQuery.fn[name];
        jQuery.fn[name] = function(speed, easing, callback) {
            return null == speed || "boolean" == typeof speed ? cssFn.apply(this, arguments) :this.animate(genFx(name, !0), speed, easing, callback);
        };
    }), jQuery.each({
        slideDown:genFx("show"),
        slideUp:genFx("hide"),
        slideToggle:genFx("toggle"),
        fadeIn:{
            opacity:"show"
        },
        fadeOut:{
            opacity:"hide"
        },
        fadeToggle:{
            opacity:"toggle"
        }
    }, function(name, props) {
        jQuery.fn[name] = function(speed, easing, callback) {
            return this.animate(props, speed, easing, callback);
        };
    }), jQuery.timers = [], jQuery.fx.tick = function() {
        var timer, timers = jQuery.timers, i = 0;
        for (fxNow = jQuery.now(); i < timers.length; i++) timer = timers[i], timer() || timers[i] !== timer || timers.splice(i--, 1);
        timers.length || jQuery.fx.stop(), fxNow = void 0;
    }, jQuery.fx.timer = function(timer) {
        jQuery.timers.push(timer), timer() ? jQuery.fx.start() :jQuery.timers.pop();
    }, jQuery.fx.interval = 13, jQuery.fx.start = function() {
        timerId || (timerId = setInterval(jQuery.fx.tick, jQuery.fx.interval));
    }, jQuery.fx.stop = function() {
        clearInterval(timerId), timerId = null;
    }, jQuery.fx.speeds = {
        slow:600,
        fast:200,
        _default:400
    }, jQuery.fn.delay = function(time, type) {
        return time = jQuery.fx ? jQuery.fx.speeds[time] || time :time, type = type || "fx", 
        this.queue(type, function(next, hooks) {
            var timeout = setTimeout(next, time);
            hooks.stop = function() {
                clearTimeout(timeout);
            };
        });
    }, function() {
        var a, input, select, opt, div = document.createElement("div");
        div.setAttribute("className", "t"), div.innerHTML = "  <link/><table></table><a href='/a'>a</a><input type='checkbox'/>", 
        a = div.getElementsByTagName("a")[0], select = document.createElement("select"), 
        opt = select.appendChild(document.createElement("option")), input = div.getElementsByTagName("input")[0], 
        a.style.cssText = "top:1px", support.getSetAttribute = "t" !== div.className, support.style = /top/.test(a.getAttribute("style")), 
        support.hrefNormalized = "/a" === a.getAttribute("href"), support.checkOn = !!input.value, 
        support.optSelected = opt.selected, support.enctype = !!document.createElement("form").enctype, 
        select.disabled = !0, support.optDisabled = !opt.disabled, input = document.createElement("input"), 
        input.setAttribute("value", ""), support.input = "" === input.getAttribute("value"), 
        input.value = "t", input.setAttribute("type", "radio"), support.radioValue = "t" === input.value, 
        a = input = select = opt = div = null;
    }();
    var rreturn = /\r/g;
    jQuery.fn.extend({
        val:function(value) {
            var hooks, ret, isFunction, elem = this[0];
            {
                if (arguments.length) return isFunction = jQuery.isFunction(value), this.each(function(i) {
                    var val;
                    1 === this.nodeType && (val = isFunction ? value.call(this, i, jQuery(this).val()) :value, 
                    null == val ? val = "" :"number" == typeof val ? val += "" :jQuery.isArray(val) && (val = jQuery.map(val, function(value) {
                        return null == value ? "" :value + "";
                    })), hooks = jQuery.valHooks[this.type] || jQuery.valHooks[this.nodeName.toLowerCase()], 
                    hooks && "set" in hooks && void 0 !== hooks.set(this, val, "value") || (this.value = val));
                });
                if (elem) return hooks = jQuery.valHooks[elem.type] || jQuery.valHooks[elem.nodeName.toLowerCase()], 
                hooks && "get" in hooks && void 0 !== (ret = hooks.get(elem, "value")) ? ret :(ret = elem.value, 
                "string" == typeof ret ? ret.replace(rreturn, "") :null == ret ? "" :ret);
            }
        }
    }), jQuery.extend({
        valHooks:{
            option:{
                get:function(elem) {
                    var val = jQuery.find.attr(elem, "value");
                    return null != val ? val :jQuery.text(elem);
                }
            },
            select:{
                get:function(elem) {
                    for (var value, option, options = elem.options, index = elem.selectedIndex, one = "select-one" === elem.type || 0 > index, values = one ? null :[], max = one ? index + 1 :options.length, i = 0 > index ? max :one ? index :0; max > i; i++) if (option = options[i], 
                    !(!option.selected && i !== index || (support.optDisabled ? option.disabled :null !== option.getAttribute("disabled")) || option.parentNode.disabled && jQuery.nodeName(option.parentNode, "optgroup"))) {
                        if (value = jQuery(option).val(), one) return value;
                        values.push(value);
                    }
                    return values;
                },
                set:function(elem, value) {
                    for (var optionSet, option, options = elem.options, values = jQuery.makeArray(value), i = options.length; i--; ) if (option = options[i], 
                    jQuery.inArray(jQuery.valHooks.option.get(option), values) >= 0) try {
                        option.selected = optionSet = !0;
                    } catch (_) {
                        option.scrollHeight;
                    } else option.selected = !1;
                    return optionSet || (elem.selectedIndex = -1), options;
                }
            }
        }
    }), jQuery.each([ "radio", "checkbox" ], function() {
        jQuery.valHooks[this] = {
            set:function(elem, value) {
                return jQuery.isArray(value) ? elem.checked = jQuery.inArray(jQuery(elem).val(), value) >= 0 :void 0;
            }
        }, support.checkOn || (jQuery.valHooks[this].get = function(elem) {
            return null === elem.getAttribute("value") ? "on" :elem.value;
        });
    });
    var nodeHook, boolHook, attrHandle = jQuery.expr.attrHandle, ruseDefault = /^(?:checked|selected)$/i, getSetAttribute = support.getSetAttribute, getSetInput = support.input;
    jQuery.fn.extend({
        attr:function(name, value) {
            return access(this, jQuery.attr, name, value, arguments.length > 1);
        },
        removeAttr:function(name) {
            return this.each(function() {
                jQuery.removeAttr(this, name);
            });
        }
    }), jQuery.extend({
        attr:function(elem, name, value) {
            var hooks, ret, nType = elem.nodeType;
            if (elem && 3 !== nType && 8 !== nType && 2 !== nType) return typeof elem.getAttribute === strundefined ? jQuery.prop(elem, name, value) :(1 === nType && jQuery.isXMLDoc(elem) || (name = name.toLowerCase(), 
            hooks = jQuery.attrHooks[name] || (jQuery.expr.match.bool.test(name) ? boolHook :nodeHook)), 
            void 0 === value ? hooks && "get" in hooks && null !== (ret = hooks.get(elem, name)) ? ret :(ret = jQuery.find.attr(elem, name), 
            null == ret ? void 0 :ret) :null !== value ? hooks && "set" in hooks && void 0 !== (ret = hooks.set(elem, value, name)) ? ret :(elem.setAttribute(name, value + ""), 
            value) :void jQuery.removeAttr(elem, name));
        },
        removeAttr:function(elem, value) {
            var name, propName, i = 0, attrNames = value && value.match(rnotwhite);
            if (attrNames && 1 === elem.nodeType) for (;name = attrNames[i++]; ) propName = jQuery.propFix[name] || name, 
            jQuery.expr.match.bool.test(name) ? getSetInput && getSetAttribute || !ruseDefault.test(name) ? elem[propName] = !1 :elem[jQuery.camelCase("default-" + name)] = elem[propName] = !1 :jQuery.attr(elem, name, ""), 
            elem.removeAttribute(getSetAttribute ? name :propName);
        },
        attrHooks:{
            type:{
                set:function(elem, value) {
                    if (!support.radioValue && "radio" === value && jQuery.nodeName(elem, "input")) {
                        var val = elem.value;
                        return elem.setAttribute("type", value), val && (elem.value = val), value;
                    }
                }
            }
        }
    }), boolHook = {
        set:function(elem, value, name) {
            return value === !1 ? jQuery.removeAttr(elem, name) :getSetInput && getSetAttribute || !ruseDefault.test(name) ? elem.setAttribute(!getSetAttribute && jQuery.propFix[name] || name, name) :elem[jQuery.camelCase("default-" + name)] = elem[name] = !0, 
            name;
        }
    }, jQuery.each(jQuery.expr.match.bool.source.match(/\w+/g), function(i, name) {
        var getter = attrHandle[name] || jQuery.find.attr;
        attrHandle[name] = getSetInput && getSetAttribute || !ruseDefault.test(name) ? function(elem, name, isXML) {
            var ret, handle;
            return isXML || (handle = attrHandle[name], attrHandle[name] = ret, ret = null != getter(elem, name, isXML) ? name.toLowerCase() :null, 
            attrHandle[name] = handle), ret;
        } :function(elem, name, isXML) {
            return isXML ? void 0 :elem[jQuery.camelCase("default-" + name)] ? name.toLowerCase() :null;
        };
    }), getSetInput && getSetAttribute || (jQuery.attrHooks.value = {
        set:function(elem, value, name) {
            return jQuery.nodeName(elem, "input") ? void (elem.defaultValue = value) :nodeHook && nodeHook.set(elem, value, name);
        }
    }), getSetAttribute || (nodeHook = {
        set:function(elem, value, name) {
            var ret = elem.getAttributeNode(name);
            return ret || elem.setAttributeNode(ret = elem.ownerDocument.createAttribute(name)), 
            ret.value = value += "", "value" === name || value === elem.getAttribute(name) ? value :void 0;
        }
    }, attrHandle.id = attrHandle.name = attrHandle.coords = function(elem, name, isXML) {
        var ret;
        return isXML ? void 0 :(ret = elem.getAttributeNode(name)) && "" !== ret.value ? ret.value :null;
    }, jQuery.valHooks.button = {
        get:function(elem, name) {
            var ret = elem.getAttributeNode(name);
            return ret && ret.specified ? ret.value :void 0;
        },
        set:nodeHook.set
    }, jQuery.attrHooks.contenteditable = {
        set:function(elem, value, name) {
            nodeHook.set(elem, "" === value ? !1 :value, name);
        }
    }, jQuery.each([ "width", "height" ], function(i, name) {
        jQuery.attrHooks[name] = {
            set:function(elem, value) {
                return "" === value ? (elem.setAttribute(name, "auto"), value) :void 0;
            }
        };
    })), support.style || (jQuery.attrHooks.style = {
        get:function(elem) {
            return elem.style.cssText || void 0;
        },
        set:function(elem, value) {
            return elem.style.cssText = value + "";
        }
    });
    var rfocusable = /^(?:input|select|textarea|button|object)$/i, rclickable = /^(?:a|area)$/i;
    jQuery.fn.extend({
        prop:function(name, value) {
            return access(this, jQuery.prop, name, value, arguments.length > 1);
        },
        removeProp:function(name) {
            return name = jQuery.propFix[name] || name, this.each(function() {
                try {
                    this[name] = void 0, delete this[name];
                } catch (e) {}
            });
        }
    }), jQuery.extend({
        propFix:{
            "for":"htmlFor",
            "class":"className"
        },
        prop:function(elem, name, value) {
            var ret, hooks, notxml, nType = elem.nodeType;
            if (elem && 3 !== nType && 8 !== nType && 2 !== nType) return notxml = 1 !== nType || !jQuery.isXMLDoc(elem), 
            notxml && (name = jQuery.propFix[name] || name, hooks = jQuery.propHooks[name]), 
            void 0 !== value ? hooks && "set" in hooks && void 0 !== (ret = hooks.set(elem, value, name)) ? ret :elem[name] = value :hooks && "get" in hooks && null !== (ret = hooks.get(elem, name)) ? ret :elem[name];
        },
        propHooks:{
            tabIndex:{
                get:function(elem) {
                    var tabindex = jQuery.find.attr(elem, "tabindex");
                    return tabindex ? parseInt(tabindex, 10) :rfocusable.test(elem.nodeName) || rclickable.test(elem.nodeName) && elem.href ? 0 :-1;
                }
            }
        }
    }), support.hrefNormalized || jQuery.each([ "href", "src" ], function(i, name) {
        jQuery.propHooks[name] = {
            get:function(elem) {
                return elem.getAttribute(name, 4);
            }
        };
    }), support.optSelected || (jQuery.propHooks.selected = {
        get:function(elem) {
            var parent = elem.parentNode;
            return parent && (parent.selectedIndex, parent.parentNode && parent.parentNode.selectedIndex), 
            null;
        }
    }), jQuery.each([ "tabIndex", "readOnly", "maxLength", "cellSpacing", "cellPadding", "rowSpan", "colSpan", "useMap", "frameBorder", "contentEditable" ], function() {
        jQuery.propFix[this.toLowerCase()] = this;
    }), support.enctype || (jQuery.propFix.enctype = "encoding");
    var rclass = /[\t\r\n\f]/g;
    jQuery.fn.extend({
        addClass:function(value) {
            var classes, elem, cur, clazz, j, finalValue, i = 0, len = this.length, proceed = "string" == typeof value && value;
            if (jQuery.isFunction(value)) return this.each(function(j) {
                jQuery(this).addClass(value.call(this, j, this.className));
            });
            if (proceed) for (classes = (value || "").match(rnotwhite) || []; len > i; i++) if (elem = this[i], 
            cur = 1 === elem.nodeType && (elem.className ? (" " + elem.className + " ").replace(rclass, " ") :" ")) {
                for (j = 0; clazz = classes[j++]; ) cur.indexOf(" " + clazz + " ") < 0 && (cur += clazz + " ");
                finalValue = jQuery.trim(cur), elem.className !== finalValue && (elem.className = finalValue);
            }
            return this;
        },
        removeClass:function(value) {
            var classes, elem, cur, clazz, j, finalValue, i = 0, len = this.length, proceed = 0 === arguments.length || "string" == typeof value && value;
            if (jQuery.isFunction(value)) return this.each(function(j) {
                jQuery(this).removeClass(value.call(this, j, this.className));
            });
            if (proceed) for (classes = (value || "").match(rnotwhite) || []; len > i; i++) if (elem = this[i], 
            cur = 1 === elem.nodeType && (elem.className ? (" " + elem.className + " ").replace(rclass, " ") :"")) {
                for (j = 0; clazz = classes[j++]; ) for (;cur.indexOf(" " + clazz + " ") >= 0; ) cur = cur.replace(" " + clazz + " ", " ");
                finalValue = value ? jQuery.trim(cur) :"", elem.className !== finalValue && (elem.className = finalValue);
            }
            return this;
        },
        toggleClass:function(value, stateVal) {
            var type = typeof value;
            return "boolean" == typeof stateVal && "string" === type ? stateVal ? this.addClass(value) :this.removeClass(value) :this.each(jQuery.isFunction(value) ? function(i) {
                jQuery(this).toggleClass(value.call(this, i, this.className, stateVal), stateVal);
            } :function() {
                if ("string" === type) for (var className, i = 0, self = jQuery(this), classNames = value.match(rnotwhite) || []; className = classNames[i++]; ) self.hasClass(className) ? self.removeClass(className) :self.addClass(className); else (type === strundefined || "boolean" === type) && (this.className && jQuery._data(this, "__className__", this.className), 
                this.className = this.className || value === !1 ? "" :jQuery._data(this, "__className__") || "");
            });
        },
        hasClass:function(selector) {
            for (var className = " " + selector + " ", i = 0, l = this.length; l > i; i++) if (1 === this[i].nodeType && (" " + this[i].className + " ").replace(rclass, " ").indexOf(className) >= 0) return !0;
            return !1;
        }
    }), jQuery.each("blur focus focusin focusout load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup error contextmenu".split(" "), function(i, name) {
        jQuery.fn[name] = function(data, fn) {
            return arguments.length > 0 ? this.on(name, null, data, fn) :this.trigger(name);
        };
    }), jQuery.fn.extend({
        hover:function(fnOver, fnOut) {
            return this.mouseenter(fnOver).mouseleave(fnOut || fnOver);
        },
        bind:function(types, data, fn) {
            return this.on(types, null, data, fn);
        },
        unbind:function(types, fn) {
            return this.off(types, null, fn);
        },
        delegate:function(selector, types, data, fn) {
            return this.on(types, selector, data, fn);
        },
        undelegate:function(selector, types, fn) {
            return 1 === arguments.length ? this.off(selector, "**") :this.off(types, selector || "**", fn);
        }
    });
    var nonce = jQuery.now(), rquery = /\?/, rvalidtokens = /(,)|(\[|{)|(}|])|"(?:[^"\\\r\n]|\\["\\\/bfnrt]|\\u[\da-fA-F]{4})*"\s*:?|true|false|null|-?(?!0\d)\d+(?:\.\d+|)(?:[eE][+-]?\d+|)/g;
    jQuery.parseJSON = function(data) {
        if (window.JSON && window.JSON.parse) return window.JSON.parse(data + "");
        var requireNonComma, depth = null, str = jQuery.trim(data + "");
        return str && !jQuery.trim(str.replace(rvalidtokens, function(token, comma, open, close) {
            return requireNonComma && comma && (depth = 0), 0 === depth ? token :(requireNonComma = open || comma, 
            depth += !close - !open, "");
        })) ? Function("return " + str)() :jQuery.error("Invalid JSON: " + data);
    }, jQuery.parseXML = function(data) {
        var xml, tmp;
        if (!data || "string" != typeof data) return null;
        try {
            window.DOMParser ? (tmp = new DOMParser(), xml = tmp.parseFromString(data, "text/xml")) :(xml = new ActiveXObject("Microsoft.XMLDOM"), 
            xml.async = "false", xml.loadXML(data));
        } catch (e) {
            xml = void 0;
        }
        return xml && xml.documentElement && !xml.getElementsByTagName("parsererror").length || jQuery.error("Invalid XML: " + data), 
        xml;
    };
    var ajaxLocParts, ajaxLocation, rhash = /#.*$/, rts = /([?&])_=[^&]*/, rheaders = /^(.*?):[ \t]*([^\r\n]*)\r?$/gm, rlocalProtocol = /^(?:about|app|app-storage|.+-extension|file|res|widget):$/, rnoContent = /^(?:GET|HEAD)$/, rprotocol = /^\/\//, rurl = /^([\w.+-]+:)(?:\/\/(?:[^\/?#]*@|)([^\/?#:]*)(?::(\d+)|)|)/, prefilters = {}, transports = {}, allTypes = "*/".concat("*");
    try {
        ajaxLocation = location.href;
    } catch (e) {
        ajaxLocation = document.createElement("a"), ajaxLocation.href = "", ajaxLocation = ajaxLocation.href;
    }
    ajaxLocParts = rurl.exec(ajaxLocation.toLowerCase()) || [], jQuery.extend({
        active:0,
        lastModified:{},
        etag:{},
        ajaxSettings:{
            url:ajaxLocation,
            type:"GET",
            isLocal:rlocalProtocol.test(ajaxLocParts[1]),
            global:!0,
            processData:!0,
            async:!0,
            contentType:"application/x-www-form-urlencoded; charset=UTF-8",
            accepts:{
                "*":allTypes,
                text:"text/plain",
                html:"text/html",
                xml:"application/xml, text/xml",
                json:"application/json, text/javascript"
            },
            contents:{
                xml:/xml/,
                html:/html/,
                json:/json/
            },
            responseFields:{
                xml:"responseXML",
                text:"responseText",
                json:"responseJSON"
            },
            converters:{
                "* text":String,
                "text html":!0,
                "text json":jQuery.parseJSON,
                "text xml":jQuery.parseXML
            },
            flatOptions:{
                url:!0,
                context:!0
            }
        },
        ajaxSetup:function(target, settings) {
            return settings ? ajaxExtend(ajaxExtend(target, jQuery.ajaxSettings), settings) :ajaxExtend(jQuery.ajaxSettings, target);
        },
        ajaxPrefilter:addToPrefiltersOrTransports(prefilters),
        ajaxTransport:addToPrefiltersOrTransports(transports),
        ajax:function(url, options) {
            function done(status, nativeStatusText, responses, headers) {
                var isSuccess, success, error, response, modified, statusText = nativeStatusText;
                2 !== state && (state = 2, timeoutTimer && clearTimeout(timeoutTimer), transport = void 0, 
                responseHeadersString = headers || "", jqXHR.readyState = status > 0 ? 4 :0, isSuccess = status >= 200 && 300 > status || 304 === status, 
                responses && (response = ajaxHandleResponses(s, jqXHR, responses)), response = ajaxConvert(s, response, jqXHR, isSuccess), 
                isSuccess ? (s.ifModified && (modified = jqXHR.getResponseHeader("Last-Modified"), 
                modified && (jQuery.lastModified[cacheURL] = modified), modified = jqXHR.getResponseHeader("etag"), 
                modified && (jQuery.etag[cacheURL] = modified)), 204 === status || "HEAD" === s.type ? statusText = "nocontent" :304 === status ? statusText = "notmodified" :(statusText = response.state, 
                success = response.data, error = response.error, isSuccess = !error)) :(error = statusText, 
                (status || !statusText) && (statusText = "error", 0 > status && (status = 0))), 
                jqXHR.status = status, jqXHR.statusText = (nativeStatusText || statusText) + "", 
                isSuccess ? deferred.resolveWith(callbackContext, [ success, statusText, jqXHR ]) :deferred.rejectWith(callbackContext, [ jqXHR, statusText, error ]), 
                jqXHR.statusCode(statusCode), statusCode = void 0, fireGlobals && globalEventContext.trigger(isSuccess ? "ajaxSuccess" :"ajaxError", [ jqXHR, s, isSuccess ? success :error ]), 
                completeDeferred.fireWith(callbackContext, [ jqXHR, statusText ]), fireGlobals && (globalEventContext.trigger("ajaxComplete", [ jqXHR, s ]), 
                --jQuery.active || jQuery.event.trigger("ajaxStop")));
            }
            "object" == typeof url && (options = url, url = void 0), options = options || {};
            var parts, i, cacheURL, responseHeadersString, timeoutTimer, fireGlobals, transport, responseHeaders, s = jQuery.ajaxSetup({}, options), callbackContext = s.context || s, globalEventContext = s.context && (callbackContext.nodeType || callbackContext.jquery) ? jQuery(callbackContext) :jQuery.event, deferred = jQuery.Deferred(), completeDeferred = jQuery.Callbacks("once memory"), statusCode = s.statusCode || {}, requestHeaders = {}, requestHeadersNames = {}, state = 0, strAbort = "canceled", jqXHR = {
                readyState:0,
                getResponseHeader:function(key) {
                    var match;
                    if (2 === state) {
                        if (!responseHeaders) for (responseHeaders = {}; match = rheaders.exec(responseHeadersString); ) responseHeaders[match[1].toLowerCase()] = match[2];
                        match = responseHeaders[key.toLowerCase()];
                    }
                    return null == match ? null :match;
                },
                getAllResponseHeaders:function() {
                    return 2 === state ? responseHeadersString :null;
                },
                setRequestHeader:function(name, value) {
                    var lname = name.toLowerCase();
                    return state || (name = requestHeadersNames[lname] = requestHeadersNames[lname] || name, 
                    requestHeaders[name] = value), this;
                },
                overrideMimeType:function(type) {
                    return state || (s.mimeType = type), this;
                },
                statusCode:function(map) {
                    var code;
                    if (map) if (2 > state) for (code in map) statusCode[code] = [ statusCode[code], map[code] ]; else jqXHR.always(map[jqXHR.status]);
                    return this;
                },
                abort:function(statusText) {
                    var finalText = statusText || strAbort;
                    return transport && transport.abort(finalText), done(0, finalText), this;
                }
            };
            if (deferred.promise(jqXHR).complete = completeDeferred.add, jqXHR.success = jqXHR.done, 
            jqXHR.error = jqXHR.fail, s.url = ((url || s.url || ajaxLocation) + "").replace(rhash, "").replace(rprotocol, ajaxLocParts[1] + "//"), 
            s.type = options.method || options.type || s.method || s.type, s.dataTypes = jQuery.trim(s.dataType || "*").toLowerCase().match(rnotwhite) || [ "" ], 
            null == s.crossDomain && (parts = rurl.exec(s.url.toLowerCase()), s.crossDomain = !(!parts || parts[1] === ajaxLocParts[1] && parts[2] === ajaxLocParts[2] && (parts[3] || ("http:" === parts[1] ? "80" :"443")) === (ajaxLocParts[3] || ("http:" === ajaxLocParts[1] ? "80" :"443")))), 
            s.data && s.processData && "string" != typeof s.data && (s.data = jQuery.param(s.data, s.traditional)), 
            inspectPrefiltersOrTransports(prefilters, s, options, jqXHR), 2 === state) return jqXHR;
            fireGlobals = s.global, fireGlobals && 0 === jQuery.active++ && jQuery.event.trigger("ajaxStart"), 
            s.type = s.type.toUpperCase(), s.hasContent = !rnoContent.test(s.type), cacheURL = s.url, 
            s.hasContent || (s.data && (cacheURL = s.url += (rquery.test(cacheURL) ? "&" :"?") + s.data, 
            delete s.data), s.cache === !1 && (s.url = rts.test(cacheURL) ? cacheURL.replace(rts, "$1_=" + nonce++) :cacheURL + (rquery.test(cacheURL) ? "&" :"?") + "_=" + nonce++)), 
            s.ifModified && (jQuery.lastModified[cacheURL] && jqXHR.setRequestHeader("If-Modified-Since", jQuery.lastModified[cacheURL]), 
            jQuery.etag[cacheURL] && jqXHR.setRequestHeader("If-None-Match", jQuery.etag[cacheURL])), 
            (s.data && s.hasContent && s.contentType !== !1 || options.contentType) && jqXHR.setRequestHeader("Content-Type", s.contentType), 
            jqXHR.setRequestHeader("Accept", s.dataTypes[0] && s.accepts[s.dataTypes[0]] ? s.accepts[s.dataTypes[0]] + ("*" !== s.dataTypes[0] ? ", " + allTypes + "; q=0.01" :"") :s.accepts["*"]);
            for (i in s.headers) jqXHR.setRequestHeader(i, s.headers[i]);
            if (s.beforeSend && (s.beforeSend.call(callbackContext, jqXHR, s) === !1 || 2 === state)) return jqXHR.abort();
            strAbort = "abort";
            for (i in {
                success:1,
                error:1,
                complete:1
            }) jqXHR[i](s[i]);
            if (transport = inspectPrefiltersOrTransports(transports, s, options, jqXHR)) {
                jqXHR.readyState = 1, fireGlobals && globalEventContext.trigger("ajaxSend", [ jqXHR, s ]), 
                s.async && s.timeout > 0 && (timeoutTimer = setTimeout(function() {
                    jqXHR.abort("timeout");
                }, s.timeout));
                try {
                    state = 1, transport.send(requestHeaders, done);
                } catch (e) {
                    if (!(2 > state)) throw e;
                    done(-1, e);
                }
            } else done(-1, "No Transport");
            return jqXHR;
        },
        getJSON:function(url, data, callback) {
            return jQuery.get(url, data, callback, "json");
        },
        getScript:function(url, callback) {
            return jQuery.get(url, void 0, callback, "script");
        }
    }), jQuery.each([ "get", "post" ], function(i, method) {
        jQuery[method] = function(url, data, callback, type) {
            return jQuery.isFunction(data) && (type = type || callback, callback = data, data = void 0), 
            jQuery.ajax({
                url:url,
                type:method,
                dataType:type,
                data:data,
                success:callback
            });
        };
    }), jQuery.each([ "ajaxStart", "ajaxStop", "ajaxComplete", "ajaxError", "ajaxSuccess", "ajaxSend" ], function(i, type) {
        jQuery.fn[type] = function(fn) {
            return this.on(type, fn);
        };
    }), jQuery._evalUrl = function(url) {
        return jQuery.ajax({
            url:url,
            type:"GET",
            dataType:"script",
            async:!1,
            global:!1,
            "throws":!0
        });
    }, jQuery.fn.extend({
        wrapAll:function(html) {
            if (jQuery.isFunction(html)) return this.each(function(i) {
                jQuery(this).wrapAll(html.call(this, i));
            });
            if (this[0]) {
                var wrap = jQuery(html, this[0].ownerDocument).eq(0).clone(!0);
                this[0].parentNode && wrap.insertBefore(this[0]), wrap.map(function() {
                    for (var elem = this; elem.firstChild && 1 === elem.firstChild.nodeType; ) elem = elem.firstChild;
                    return elem;
                }).append(this);
            }
            return this;
        },
        wrapInner:function(html) {
            return this.each(jQuery.isFunction(html) ? function(i) {
                jQuery(this).wrapInner(html.call(this, i));
            } :function() {
                var self = jQuery(this), contents = self.contents();
                contents.length ? contents.wrapAll(html) :self.append(html);
            });
        },
        wrap:function(html) {
            var isFunction = jQuery.isFunction(html);
            return this.each(function(i) {
                jQuery(this).wrapAll(isFunction ? html.call(this, i) :html);
            });
        },
        unwrap:function() {
            return this.parent().each(function() {
                jQuery.nodeName(this, "body") || jQuery(this).replaceWith(this.childNodes);
            }).end();
        }
    }), jQuery.expr.filters.hidden = function(elem) {
        return elem.offsetWidth <= 0 && elem.offsetHeight <= 0 || !support.reliableHiddenOffsets() && "none" === (elem.style && elem.style.display || jQuery.css(elem, "display"));
    }, jQuery.expr.filters.visible = function(elem) {
        return !jQuery.expr.filters.hidden(elem);
    };
    var r20 = /%20/g, rbracket = /\[\]$/, rCRLF = /\r?\n/g, rsubmitterTypes = /^(?:submit|button|image|reset|file)$/i, rsubmittable = /^(?:input|select|textarea|keygen)/i;
    jQuery.param = function(a, traditional) {
        var prefix, s = [], add = function(key, value) {
            value = jQuery.isFunction(value) ? value() :null == value ? "" :value, s[s.length] = encodeURIComponent(key) + "=" + encodeURIComponent(value);
        };
        if (void 0 === traditional && (traditional = jQuery.ajaxSettings && jQuery.ajaxSettings.traditional), 
        jQuery.isArray(a) || a.jquery && !jQuery.isPlainObject(a)) jQuery.each(a, function() {
            add(this.name, this.value);
        }); else for (prefix in a) buildParams(prefix, a[prefix], traditional, add);
        return s.join("&").replace(r20, "+");
    }, jQuery.fn.extend({
        serialize:function() {
            return jQuery.param(this.serializeArray());
        },
        serializeArray:function() {
            return this.map(function() {
                var elements = jQuery.prop(this, "elements");
                return elements ? jQuery.makeArray(elements) :this;
            }).filter(function() {
                var type = this.type;
                return this.name && !jQuery(this).is(":disabled") && rsubmittable.test(this.nodeName) && !rsubmitterTypes.test(type) && (this.checked || !rcheckableType.test(type));
            }).map(function(i, elem) {
                var val = jQuery(this).val();
                return null == val ? null :jQuery.isArray(val) ? jQuery.map(val, function(val) {
                    return {
                        name:elem.name,
                        value:val.replace(rCRLF, "\r\n")
                    };
                }) :{
                    name:elem.name,
                    value:val.replace(rCRLF, "\r\n")
                };
            }).get();
        }
    }), jQuery.ajaxSettings.xhr = void 0 !== window.ActiveXObject ? function() {
        return !this.isLocal && /^(get|post|head|put|delete|options)$/i.test(this.type) && createStandardXHR() || createActiveXHR();
    } :createStandardXHR;
    var xhrId = 0, xhrCallbacks = {}, xhrSupported = jQuery.ajaxSettings.xhr();
    window.ActiveXObject && jQuery(window).on("unload", function() {
        for (var key in xhrCallbacks) xhrCallbacks[key](void 0, !0);
    }), support.cors = !!xhrSupported && "withCredentials" in xhrSupported, xhrSupported = support.ajax = !!xhrSupported, 
    xhrSupported && jQuery.ajaxTransport(function(options) {
        if (!options.crossDomain || support.cors) {
            var callback;
            return {
                send:function(headers, complete) {
                    var i, xhr = options.xhr(), id = ++xhrId;
                    if (xhr.open(options.type, options.url, options.async, options.username, options.password), 
                    options.xhrFields) for (i in options.xhrFields) xhr[i] = options.xhrFields[i];
                    options.mimeType && xhr.overrideMimeType && xhr.overrideMimeType(options.mimeType), 
                    options.crossDomain || headers["X-Requested-With"] || (headers["X-Requested-With"] = "XMLHttpRequest");
                    for (i in headers) void 0 !== headers[i] && xhr.setRequestHeader(i, headers[i] + "");
                    xhr.send(options.hasContent && options.data || null), callback = function(_, isAbort) {
                        var status, statusText, responses;
                        if (callback && (isAbort || 4 === xhr.readyState)) if (delete xhrCallbacks[id], 
                        callback = void 0, xhr.onreadystatechange = jQuery.noop, isAbort) 4 !== xhr.readyState && xhr.abort(); else {
                            responses = {}, status = xhr.status, "string" == typeof xhr.responseText && (responses.text = xhr.responseText);
                            try {
                                statusText = xhr.statusText;
                            } catch (e) {
                                statusText = "";
                            }
                            status || !options.isLocal || options.crossDomain ? 1223 === status && (status = 204) :status = responses.text ? 200 :404;
                        }
                        responses && complete(status, statusText, responses, xhr.getAllResponseHeaders());
                    }, options.async ? 4 === xhr.readyState ? setTimeout(callback) :xhr.onreadystatechange = xhrCallbacks[id] = callback :callback();
                },
                abort:function() {
                    callback && callback(void 0, !0);
                }
            };
        }
    }), jQuery.ajaxSetup({
        accepts:{
            script:"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"
        },
        contents:{
            script:/(?:java|ecma)script/
        },
        converters:{
            "text script":function(text) {
                return jQuery.globalEval(text), text;
            }
        }
    }), jQuery.ajaxPrefilter("script", function(s) {
        void 0 === s.cache && (s.cache = !1), s.crossDomain && (s.type = "GET", s.global = !1);
    }), jQuery.ajaxTransport("script", function(s) {
        if (s.crossDomain) {
            var script, head = document.head || jQuery("head")[0] || document.documentElement;
            return {
                send:function(_, callback) {
                    script = document.createElement("script"), script.async = !0, s.scriptCharset && (script.charset = s.scriptCharset), 
                    script.src = s.url, script.onload = script.onreadystatechange = function(_, isAbort) {
                        (isAbort || !script.readyState || /loaded|complete/.test(script.readyState)) && (script.onload = script.onreadystatechange = null, 
                        script.parentNode && script.parentNode.removeChild(script), script = null, isAbort || callback(200, "success"));
                    }, head.insertBefore(script, head.firstChild);
                },
                abort:function() {
                    script && script.onload(void 0, !0);
                }
            };
        }
    });
    var oldCallbacks = [], rjsonp = /(=)\?(?=&|$)|\?\?/;
    jQuery.ajaxSetup({
        jsonp:"callback",
        jsonpCallback:function() {
            var callback = oldCallbacks.pop() || jQuery.expando + "_" + nonce++;
            return this[callback] = !0, callback;
        }
    }), jQuery.ajaxPrefilter("json jsonp", function(s, originalSettings, jqXHR) {
        var callbackName, overwritten, responseContainer, jsonProp = s.jsonp !== !1 && (rjsonp.test(s.url) ? "url" :"string" == typeof s.data && !(s.contentType || "").indexOf("application/x-www-form-urlencoded") && rjsonp.test(s.data) && "data");
        return jsonProp || "jsonp" === s.dataTypes[0] ? (callbackName = s.jsonpCallback = jQuery.isFunction(s.jsonpCallback) ? s.jsonpCallback() :s.jsonpCallback, 
        jsonProp ? s[jsonProp] = s[jsonProp].replace(rjsonp, "$1" + callbackName) :s.jsonp !== !1 && (s.url += (rquery.test(s.url) ? "&" :"?") + s.jsonp + "=" + callbackName), 
        s.converters["script json"] = function() {
            return responseContainer || jQuery.error(callbackName + " was not called"), responseContainer[0];
        }, s.dataTypes[0] = "json", overwritten = window[callbackName], window[callbackName] = function() {
            responseContainer = arguments;
        }, jqXHR.always(function() {
            window[callbackName] = overwritten, s[callbackName] && (s.jsonpCallback = originalSettings.jsonpCallback, 
            oldCallbacks.push(callbackName)), responseContainer && jQuery.isFunction(overwritten) && overwritten(responseContainer[0]), 
            responseContainer = overwritten = void 0;
        }), "script") :void 0;
    }), jQuery.parseHTML = function(data, context, keepScripts) {
        if (!data || "string" != typeof data) return null;
        "boolean" == typeof context && (keepScripts = context, context = !1), context = context || document;
        var parsed = rsingleTag.exec(data), scripts = !keepScripts && [];
        return parsed ? [ context.createElement(parsed[1]) ] :(parsed = jQuery.buildFragment([ data ], context, scripts), 
        scripts && scripts.length && jQuery(scripts).remove(), jQuery.merge([], parsed.childNodes));
    };
    var _load = jQuery.fn.load;
    jQuery.fn.load = function(url, params, callback) {
        if ("string" != typeof url && _load) return _load.apply(this, arguments);
        var selector, response, type, self = this, off = url.indexOf(" ");
        return off >= 0 && (selector = url.slice(off, url.length), url = url.slice(0, off)), 
        jQuery.isFunction(params) ? (callback = params, params = void 0) :params && "object" == typeof params && (type = "POST"), 
        self.length > 0 && jQuery.ajax({
            url:url,
            type:type,
            dataType:"html",
            data:params
        }).done(function(responseText) {
            response = arguments, self.html(selector ? jQuery("<div>").append(jQuery.parseHTML(responseText)).find(selector) :responseText);
        }).complete(callback && function(jqXHR, status) {
            self.each(callback, response || [ jqXHR.responseText, status, jqXHR ]);
        }), this;
    }, jQuery.expr.filters.animated = function(elem) {
        return jQuery.grep(jQuery.timers, function(fn) {
            return elem === fn.elem;
        }).length;
    };
    var docElem = window.document.documentElement;
    jQuery.offset = {
        setOffset:function(elem, options, i) {
            var curPosition, curLeft, curCSSTop, curTop, curOffset, curCSSLeft, calculatePosition, position = jQuery.css(elem, "position"), curElem = jQuery(elem), props = {};
            "static" === position && (elem.style.position = "relative"), curOffset = curElem.offset(), 
            curCSSTop = jQuery.css(elem, "top"), curCSSLeft = jQuery.css(elem, "left"), calculatePosition = ("absolute" === position || "fixed" === position) && jQuery.inArray("auto", [ curCSSTop, curCSSLeft ]) > -1, 
            calculatePosition ? (curPosition = curElem.position(), curTop = curPosition.top, 
            curLeft = curPosition.left) :(curTop = parseFloat(curCSSTop) || 0, curLeft = parseFloat(curCSSLeft) || 0), 
            jQuery.isFunction(options) && (options = options.call(elem, i, curOffset)), null != options.top && (props.top = options.top - curOffset.top + curTop), 
            null != options.left && (props.left = options.left - curOffset.left + curLeft), 
            "using" in options ? options.using.call(elem, props) :curElem.css(props);
        }
    }, jQuery.fn.extend({
        offset:function(options) {
            if (arguments.length) return void 0 === options ? this :this.each(function(i) {
                jQuery.offset.setOffset(this, options, i);
            });
            var docElem, win, box = {
                top:0,
                left:0
            }, elem = this[0], doc = elem && elem.ownerDocument;
            if (doc) return docElem = doc.documentElement, jQuery.contains(docElem, elem) ? (typeof elem.getBoundingClientRect !== strundefined && (box = elem.getBoundingClientRect()), 
            win = getWindow(doc), {
                top:box.top + (win.pageYOffset || docElem.scrollTop) - (docElem.clientTop || 0),
                left:box.left + (win.pageXOffset || docElem.scrollLeft) - (docElem.clientLeft || 0)
            }) :box;
        },
        position:function() {
            if (this[0]) {
                var offsetParent, offset, parentOffset = {
                    top:0,
                    left:0
                }, elem = this[0];
                return "fixed" === jQuery.css(elem, "position") ? offset = elem.getBoundingClientRect() :(offsetParent = this.offsetParent(), 
                offset = this.offset(), jQuery.nodeName(offsetParent[0], "html") || (parentOffset = offsetParent.offset()), 
                parentOffset.top += jQuery.css(offsetParent[0], "borderTopWidth", !0), parentOffset.left += jQuery.css(offsetParent[0], "borderLeftWidth", !0)), 
                {
                    top:offset.top - parentOffset.top - jQuery.css(elem, "marginTop", !0),
                    left:offset.left - parentOffset.left - jQuery.css(elem, "marginLeft", !0)
                };
            }
        },
        offsetParent:function() {
            return this.map(function() {
                for (var offsetParent = this.offsetParent || docElem; offsetParent && !jQuery.nodeName(offsetParent, "html") && "static" === jQuery.css(offsetParent, "position"); ) offsetParent = offsetParent.offsetParent;
                return offsetParent || docElem;
            });
        }
    }), jQuery.each({
        scrollLeft:"pageXOffset",
        scrollTop:"pageYOffset"
    }, function(method, prop) {
        var top = /Y/.test(prop);
        jQuery.fn[method] = function(val) {
            return access(this, function(elem, method, val) {
                var win = getWindow(elem);
                return void 0 === val ? win ? prop in win ? win[prop] :win.document.documentElement[method] :elem[method] :void (win ? win.scrollTo(top ? jQuery(win).scrollLeft() :val, top ? val :jQuery(win).scrollTop()) :elem[method] = val);
            }, method, val, arguments.length, null);
        };
    }), jQuery.each([ "top", "left" ], function(i, prop) {
        jQuery.cssHooks[prop] = addGetHookIf(support.pixelPosition, function(elem, computed) {
            return computed ? (computed = curCSS(elem, prop), rnumnonpx.test(computed) ? jQuery(elem).position()[prop] + "px" :computed) :void 0;
        });
    }), jQuery.each({
        Height:"height",
        Width:"width"
    }, function(name, type) {
        jQuery.each({
            padding:"inner" + name,
            content:type,
            "":"outer" + name
        }, function(defaultExtra, funcName) {
            jQuery.fn[funcName] = function(margin, value) {
                var chainable = arguments.length && (defaultExtra || "boolean" != typeof margin), extra = defaultExtra || (margin === !0 || value === !0 ? "margin" :"border");
                return access(this, function(elem, type, value) {
                    var doc;
                    return jQuery.isWindow(elem) ? elem.document.documentElement["client" + name] :9 === elem.nodeType ? (doc = elem.documentElement, 
                    Math.max(elem.body["scroll" + name], doc["scroll" + name], elem.body["offset" + name], doc["offset" + name], doc["client" + name])) :void 0 === value ? jQuery.css(elem, type, extra) :jQuery.style(elem, type, value, extra);
                }, type, chainable ? margin :void 0, chainable, null);
            };
        });
    }), jQuery.fn.size = function() {
        return this.length;
    }, jQuery.fn.andSelf = jQuery.fn.addBack, "function" == typeof define && define.amd && define("jquery", [], function() {
        return jQuery;
    });
    var _jQuery = window.jQuery, _$ = window.$;
    return jQuery.noConflict = function(deep) {
        return window.$ === jQuery && (window.$ = _$), deep && window.jQuery === jQuery && (window.jQuery = _jQuery), 
        jQuery;
    }, typeof noGlobal === strundefined && (window.jQuery = window.$ = jQuery), jQuery;
}), function($, undefined) {
    $.rails !== undefined && $.error("jquery-ujs has already been loaded!");
    var rails, $document = $(document);
    $.rails = rails = {
        linkClickSelector:"a[data-confirm], a[data-method], a[data-remote], a[data-disable-with]",
        buttonClickSelector:"button[data-remote]",
        inputChangeSelector:"select[data-remote], input[data-remote], textarea[data-remote]",
        formSubmitSelector:"form",
        formInputClickSelector:"form input[type=submit], form input[type=image], form button[type=submit], form button:not([type])",
        disableSelector:"input[data-disable-with], button[data-disable-with], textarea[data-disable-with]",
        enableSelector:"input[data-disable-with]:disabled, button[data-disable-with]:disabled, textarea[data-disable-with]:disabled",
        requiredInputSelector:"input[name][required]:not([disabled]),textarea[name][required]:not([disabled])",
        fileInputSelector:"input[type=file]",
        linkDisableSelector:"a[data-disable-with]",
        CSRFProtection:function(xhr) {
            var token = $('meta[name="csrf-token"]').attr("content");
            token && xhr.setRequestHeader("X-CSRF-Token", token);
        },
        refreshCSRFTokens:function() {
            var csrfToken = $("meta[name=csrf-token]").attr("content"), csrfParam = $("meta[name=csrf-param]").attr("content");
            $('form input[name="' + csrfParam + '"]').val(csrfToken);
        },
        fire:function(obj, name, data) {
            var event = $.Event(name);
            return obj.trigger(event, data), event.result !== !1;
        },
        confirm:function(message) {
            return confirm(message);
        },
        ajax:function(options) {
            return $.ajax(options);
        },
        href:function(element) {
            return element.attr("href");
        },
        handleRemote:function(element) {
            var method, url, data, elCrossDomain, crossDomain, withCredentials, dataType, options;
            if (rails.fire(element, "ajax:before")) {
                if (elCrossDomain = element.data("cross-domain"), crossDomain = elCrossDomain === undefined ? null :elCrossDomain, 
                withCredentials = element.data("with-credentials") || null, dataType = element.data("type") || $.ajaxSettings && $.ajaxSettings.dataType, 
                element.is("form")) {
                    method = element.attr("method"), url = element.attr("action"), data = element.serializeArray();
                    var button = element.data("ujs:submit-button");
                    button && (data.push(button), element.data("ujs:submit-button", null));
                } else element.is(rails.inputChangeSelector) ? (method = element.data("method"), 
                url = element.data("url"), data = element.serialize(), element.data("params") && (data = data + "&" + element.data("params"))) :element.is(rails.buttonClickSelector) ? (method = element.data("method") || "get", 
                url = element.data("url"), data = element.serialize(), element.data("params") && (data = data + "&" + element.data("params"))) :(method = element.data("method"), 
                url = rails.href(element), data = element.data("params") || null);
                options = {
                    type:method || "GET",
                    data:data,
                    dataType:dataType,
                    beforeSend:function(xhr, settings) {
                        return settings.dataType === undefined && xhr.setRequestHeader("accept", "*/*;q=0.5, " + settings.accepts.script), 
                        rails.fire(element, "ajax:beforeSend", [ xhr, settings ]);
                    },
                    success:function(data, status, xhr) {
                        element.trigger("ajax:success", [ data, status, xhr ]);
                    },
                    complete:function(xhr, status) {
                        element.trigger("ajax:complete", [ xhr, status ]);
                    },
                    error:function(xhr, status, error) {
                        element.trigger("ajax:error", [ xhr, status, error ]);
                    },
                    crossDomain:crossDomain
                }, withCredentials && (options.xhrFields = {
                    withCredentials:withCredentials
                }), url && (options.url = url);
                var jqxhr = rails.ajax(options);
                return element.trigger("ajax:send", jqxhr), jqxhr;
            }
            return !1;
        },
        handleMethod:function(link) {
            var href = rails.href(link), method = link.data("method"), target = link.attr("target"), csrfToken = $("meta[name=csrf-token]").attr("content"), csrfParam = $("meta[name=csrf-param]").attr("content"), form = $('<form method="post" action="' + href + '"></form>'), metadataInput = '<input name="_method" value="' + method + '" type="hidden" />';
            csrfParam !== undefined && csrfToken !== undefined && (metadataInput += '<input name="' + csrfParam + '" value="' + csrfToken + '" type="hidden" />'), 
            target && form.attr("target", target), form.hide().append(metadataInput).appendTo("body"), 
            form.submit();
        },
        disableFormElements:function(form) {
            form.find(rails.disableSelector).each(function() {
                var element = $(this), method = element.is("button") ? "html" :"val";
                element.data("ujs:enable-with", element[method]()), element[method](element.data("disable-with")), 
                element.prop("disabled", !0);
            });
        },
        enableFormElements:function(form) {
            form.find(rails.enableSelector).each(function() {
                var element = $(this), method = element.is("button") ? "html" :"val";
                element.data("ujs:enable-with") && element[method](element.data("ujs:enable-with")), 
                element.prop("disabled", !1);
            });
        },
        allowAction:function(element) {
            var callback, message = element.data("confirm"), answer = !1;
            return message ? (rails.fire(element, "confirm") && (answer = rails.confirm(message), 
            callback = rails.fire(element, "confirm:complete", [ answer ])), answer && callback) :!0;
        },
        blankInputs:function(form, specifiedSelector, nonBlank) {
            var input, valueToCheck, inputs = $(), selector = specifiedSelector || "input,textarea", allInputs = form.find(selector);
            return allInputs.each(function() {
                if (input = $(this), valueToCheck = input.is("input[type=checkbox],input[type=radio]") ? input.is(":checked") :input.val(), 
                !valueToCheck == !nonBlank) {
                    if (input.is("input[type=radio]") && allInputs.filter('input[type=radio]:checked[name="' + input.attr("name") + '"]').length) return !0;
                    inputs = inputs.add(input);
                }
            }), inputs.length ? inputs :!1;
        },
        nonBlankInputs:function(form, specifiedSelector) {
            return rails.blankInputs(form, specifiedSelector, !0);
        },
        stopEverything:function(e) {
            return $(e.target).trigger("ujs:everythingStopped"), e.stopImmediatePropagation(), 
            !1;
        },
        disableElement:function(element) {
            element.data("ujs:enable-with", element.html()), element.html(element.data("disable-with")), 
            element.bind("click.railsDisable", function(e) {
                return rails.stopEverything(e);
            });
        },
        enableElement:function(element) {
            element.data("ujs:enable-with") !== undefined && (element.html(element.data("ujs:enable-with")), 
            element.removeData("ujs:enable-with")), element.unbind("click.railsDisable");
        }
    }, rails.fire($document, "rails:attachBindings") && ($.ajaxPrefilter(function(options, originalOptions, xhr) {
        options.crossDomain || rails.CSRFProtection(xhr);
    }), $document.delegate(rails.linkDisableSelector, "ajax:complete", function() {
        rails.enableElement($(this));
    }), $document.delegate(rails.linkClickSelector, "click.rails", function(e) {
        var link = $(this), method = link.data("method"), data = link.data("params"), metaClick = e.metaKey || e.ctrlKey;
        if (!rails.allowAction(link)) return rails.stopEverything(e);
        if (!metaClick && link.is(rails.linkDisableSelector) && rails.disableElement(link), 
        link.data("remote") !== undefined) {
            if (metaClick && (!method || "GET" === method) && !data) return !0;
            var handleRemote = rails.handleRemote(link);
            return handleRemote === !1 ? rails.enableElement(link) :handleRemote.error(function() {
                rails.enableElement(link);
            }), !1;
        }
        return link.data("method") ? (rails.handleMethod(link), !1) :void 0;
    }), $document.delegate(rails.buttonClickSelector, "click.rails", function(e) {
        var button = $(this);
        return rails.allowAction(button) ? (rails.handleRemote(button), !1) :rails.stopEverything(e);
    }), $document.delegate(rails.inputChangeSelector, "change.rails", function(e) {
        var link = $(this);
        return rails.allowAction(link) ? (rails.handleRemote(link), !1) :rails.stopEverything(e);
    }), $document.delegate(rails.formSubmitSelector, "submit.rails", function(e) {
        var form = $(this), remote = form.data("remote") !== undefined, blankRequiredInputs = rails.blankInputs(form, rails.requiredInputSelector), nonBlankFileInputs = rails.nonBlankInputs(form, rails.fileInputSelector);
        if (!rails.allowAction(form)) return rails.stopEverything(e);
        if (blankRequiredInputs && form.attr("novalidate") == undefined && rails.fire(form, "ajax:aborted:required", [ blankRequiredInputs ])) return rails.stopEverything(e);
        if (remote) {
            if (nonBlankFileInputs) {
                setTimeout(function() {
                    rails.disableFormElements(form);
                }, 13);
                var aborted = rails.fire(form, "ajax:aborted:file", [ nonBlankFileInputs ]);
                return aborted || setTimeout(function() {
                    rails.enableFormElements(form);
                }, 13), aborted;
            }
            return rails.handleRemote(form), !1;
        }
        setTimeout(function() {
            rails.disableFormElements(form);
        }, 13);
    }), $document.delegate(rails.formInputClickSelector, "click.rails", function(event) {
        var button = $(this);
        if (!rails.allowAction(button)) return rails.stopEverything(event);
        var name = button.attr("name"), data = name ? {
            name:name,
            value:button.val()
        } :null;
        button.closest("form").data("ujs:submit-button", data);
    }), $document.delegate(rails.formSubmitSelector, "ajax:beforeSend.rails", function(event) {
        this == event.target && rails.disableFormElements($(this));
    }), $document.delegate(rails.formSubmitSelector, "ajax:complete.rails", function(event) {
        this == event.target && rails.enableFormElements($(this));
    }), $(function() {
        rails.refreshCSRFTokens();
    }));
}(jQuery), "undefined" == typeof jQuery) throw new Error("Bootstrap requires jQuery");

/* ========================================================================
 * Bootstrap: transition.js v3.1.0
 * http://getbootstrap.com/javascript/#transitions
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    function transitionEnd() {
        var el = document.createElement("bootstrap"), transEndEventNames = {
            WebkitTransition:"webkitTransitionEnd",
            MozTransition:"transitionend",
            OTransition:"oTransitionEnd otransitionend",
            transition:"transitionend"
        };
        for (var name in transEndEventNames) if (void 0 !== el.style[name]) return {
            end:transEndEventNames[name]
        };
        return !1;
    }
    $.fn.emulateTransitionEnd = function(duration) {
        var called = !1, $el = this;
        $(this).one($.support.transition.end, function() {
            called = !0;
        });
        var callback = function() {
            called || $($el).trigger($.support.transition.end);
        };
        return setTimeout(callback, duration), this;
    }, $(function() {
        $.support.transition = transitionEnd();
    });
}(jQuery), /* ========================================================================
 * Bootstrap: alert.js v3.1.0
 * http://getbootstrap.com/javascript/#alerts
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var dismiss = '[data-dismiss="alert"]', Alert = function(el) {
        $(el).on("click", dismiss, this.close);
    };
    Alert.prototype.close = function(e) {
        function removeElement() {
            $parent.trigger("closed.bs.alert").remove();
        }
        var $this = $(this), selector = $this.attr("data-target");
        selector || (selector = $this.attr("href"), selector = selector && selector.replace(/.*(?=#[^\s]*$)/, ""));
        var $parent = $(selector);
        e && e.preventDefault(), $parent.length || ($parent = $this.hasClass("alert") ? $this :$this.parent()), 
        $parent.trigger(e = $.Event("close.bs.alert")), e.isDefaultPrevented() || ($parent.removeClass("in"), 
        $.support.transition && $parent.hasClass("fade") ? $parent.one($.support.transition.end, removeElement).emulateTransitionEnd(150) :removeElement());
    };
    var old = $.fn.alert;
    $.fn.alert = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.alert");
            data || $this.data("bs.alert", data = new Alert(this)), "string" == typeof option && data[option].call($this);
        });
    }, $.fn.alert.Constructor = Alert, $.fn.alert.noConflict = function() {
        return $.fn.alert = old, this;
    }, $(document).on("click.bs.alert.data-api", dismiss, Alert.prototype.close);
}(jQuery), /* ========================================================================
 * Bootstrap: button.js v3.1.0
 * http://getbootstrap.com/javascript/#buttons
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Button = function(element, options) {
        this.$element = $(element), this.options = $.extend({}, Button.DEFAULTS, options), 
        this.isLoading = !1;
    };
    Button.DEFAULTS = {
        loadingText:"loading..."
    }, Button.prototype.setState = function(state) {
        var d = "disabled", $el = this.$element, val = $el.is("input") ? "val" :"html", data = $el.data();
        state += "Text", data.resetText || $el.data("resetText", $el[val]()), $el[val](data[state] || this.options[state]), 
        setTimeout($.proxy(function() {
            "loadingText" == state ? (this.isLoading = !0, $el.addClass(d).attr(d, d)) :this.isLoading && (this.isLoading = !1, 
            $el.removeClass(d).removeAttr(d));
        }, this), 0);
    }, Button.prototype.toggle = function() {
        var changed = !0, $parent = this.$element.closest('[data-toggle="buttons"]');
        if ($parent.length) {
            var $input = this.$element.find("input");
            "radio" == $input.prop("type") && ($input.prop("checked") && this.$element.hasClass("active") ? changed = !1 :$parent.find(".active").removeClass("active")), 
            changed && $input.prop("checked", !this.$element.hasClass("active")).trigger("change");
        }
        changed && this.$element.toggleClass("active");
    };
    var old = $.fn.button;
    $.fn.button = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.button"), options = "object" == typeof option && option;
            data || $this.data("bs.button", data = new Button(this, options)), "toggle" == option ? data.toggle() :option && data.setState(option);
        });
    }, $.fn.button.Constructor = Button, $.fn.button.noConflict = function() {
        return $.fn.button = old, this;
    }, $(document).on("click.bs.button.data-api", "[data-toggle^=button]", function(e) {
        var $btn = $(e.target);
        $btn.hasClass("btn") || ($btn = $btn.closest(".btn")), $btn.button("toggle"), e.preventDefault();
    });
}(jQuery), /* ========================================================================
 * Bootstrap: carousel.js v3.1.0
 * http://getbootstrap.com/javascript/#carousel
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Carousel = function(element, options) {
        this.$element = $(element), this.$indicators = this.$element.find(".carousel-indicators"), 
        this.options = options, this.paused = this.sliding = this.interval = this.$active = this.$items = null, 
        "hover" == this.options.pause && this.$element.on("mouseenter", $.proxy(this.pause, this)).on("mouseleave", $.proxy(this.cycle, this));
    };
    Carousel.DEFAULTS = {
        interval:5e3,
        pause:"hover",
        wrap:!0
    }, Carousel.prototype.cycle = function(e) {
        return e || (this.paused = !1), this.interval && clearInterval(this.interval), this.options.interval && !this.paused && (this.interval = setInterval($.proxy(this.next, this), this.options.interval)), 
        this;
    }, Carousel.prototype.getActiveIndex = function() {
        return this.$active = this.$element.find(".item.active"), this.$items = this.$active.parent().children(), 
        this.$items.index(this.$active);
    }, Carousel.prototype.to = function(pos) {
        var that = this, activeIndex = this.getActiveIndex();
        return pos > this.$items.length - 1 || 0 > pos ? void 0 :this.sliding ? this.$element.one("slid.bs.carousel", function() {
            that.to(pos);
        }) :activeIndex == pos ? this.pause().cycle() :this.slide(pos > activeIndex ? "next" :"prev", $(this.$items[pos]));
    }, Carousel.prototype.pause = function(e) {
        return e || (this.paused = !0), this.$element.find(".next, .prev").length && $.support.transition && (this.$element.trigger($.support.transition.end), 
        this.cycle(!0)), this.interval = clearInterval(this.interval), this;
    }, Carousel.prototype.next = function() {
        return this.sliding ? void 0 :this.slide("next");
    }, Carousel.prototype.prev = function() {
        return this.sliding ? void 0 :this.slide("prev");
    }, Carousel.prototype.slide = function(type, next) {
        var $active = this.$element.find(".item.active"), $next = next || $active[type](), isCycling = this.interval, direction = "next" == type ? "left" :"right", fallback = "next" == type ? "first" :"last", that = this;
        if (!$next.length) {
            if (!this.options.wrap) return;
            $next = this.$element.find(".item")[fallback]();
        }
        if ($next.hasClass("active")) return this.sliding = !1;
        var e = $.Event("slide.bs.carousel", {
            relatedTarget:$next[0],
            direction:direction
        });
        return this.$element.trigger(e), e.isDefaultPrevented() ? void 0 :(this.sliding = !0, 
        isCycling && this.pause(), this.$indicators.length && (this.$indicators.find(".active").removeClass("active"), 
        this.$element.one("slid.bs.carousel", function() {
            var $nextIndicator = $(that.$indicators.children()[that.getActiveIndex()]);
            $nextIndicator && $nextIndicator.addClass("active");
        })), $.support.transition && this.$element.hasClass("slide") ? ($next.addClass(type), 
        $next[0].offsetWidth, $active.addClass(direction), $next.addClass(direction), $active.one($.support.transition.end, function() {
            $next.removeClass([ type, direction ].join(" ")).addClass("active"), $active.removeClass([ "active", direction ].join(" ")), 
            that.sliding = !1, setTimeout(function() {
                that.$element.trigger("slid.bs.carousel");
            }, 0);
        }).emulateTransitionEnd(1e3 * $active.css("transition-duration").slice(0, -1))) :($active.removeClass("active"), 
        $next.addClass("active"), this.sliding = !1, this.$element.trigger("slid.bs.carousel")), 
        isCycling && this.cycle(), this);
    };
    var old = $.fn.carousel;
    $.fn.carousel = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.carousel"), options = $.extend({}, Carousel.DEFAULTS, $this.data(), "object" == typeof option && option), action = "string" == typeof option ? option :options.slide;
            data || $this.data("bs.carousel", data = new Carousel(this, options)), "number" == typeof option ? data.to(option) :action ? data[action]() :options.interval && data.pause().cycle();
        });
    }, $.fn.carousel.Constructor = Carousel, $.fn.carousel.noConflict = function() {
        return $.fn.carousel = old, this;
    }, $(document).on("click.bs.carousel.data-api", "[data-slide], [data-slide-to]", function(e) {
        var href, $this = $(this), $target = $($this.attr("data-target") || (href = $this.attr("href")) && href.replace(/.*(?=#[^\s]+$)/, "")), options = $.extend({}, $target.data(), $this.data()), slideIndex = $this.attr("data-slide-to");
        slideIndex && (options.interval = !1), $target.carousel(options), (slideIndex = $this.attr("data-slide-to")) && $target.data("bs.carousel").to(slideIndex), 
        e.preventDefault();
    }), $(window).on("load", function() {
        $('[data-ride="carousel"]').each(function() {
            var $carousel = $(this);
            $carousel.carousel($carousel.data());
        });
    });
}(jQuery), /* ========================================================================
 * Bootstrap: collapse.js v3.1.0
 * http://getbootstrap.com/javascript/#collapse
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Collapse = function(element, options) {
        this.$element = $(element), this.options = $.extend({}, Collapse.DEFAULTS, options), 
        this.transitioning = null, this.options.parent && (this.$parent = $(this.options.parent)), 
        this.options.toggle && this.toggle();
    };
    Collapse.DEFAULTS = {
        toggle:!0
    }, Collapse.prototype.dimension = function() {
        var hasWidth = this.$element.hasClass("width");
        return hasWidth ? "width" :"height";
    }, Collapse.prototype.show = function() {
        if (!this.transitioning && !this.$element.hasClass("in")) {
            var startEvent = $.Event("show.bs.collapse");
            if (this.$element.trigger(startEvent), !startEvent.isDefaultPrevented()) {
                var actives = this.$parent && this.$parent.find("> .panel > .in");
                if (actives && actives.length) {
                    var hasData = actives.data("bs.collapse");
                    if (hasData && hasData.transitioning) return;
                    actives.collapse("hide"), hasData || actives.data("bs.collapse", null);
                }
                var dimension = this.dimension();
                this.$element.removeClass("collapse").addClass("collapsing")[dimension](0), this.transitioning = 1;
                var complete = function() {
                    this.$element.removeClass("collapsing").addClass("collapse in")[dimension]("auto"), 
                    this.transitioning = 0, this.$element.trigger("shown.bs.collapse");
                };
                if (!$.support.transition) return complete.call(this);
                var scrollSize = $.camelCase([ "scroll", dimension ].join("-"));
                this.$element.one($.support.transition.end, $.proxy(complete, this)).emulateTransitionEnd(350)[dimension](this.$element[0][scrollSize]);
            }
        }
    }, Collapse.prototype.hide = function() {
        if (!this.transitioning && this.$element.hasClass("in")) {
            var startEvent = $.Event("hide.bs.collapse");
            if (this.$element.trigger(startEvent), !startEvent.isDefaultPrevented()) {
                var dimension = this.dimension();
                this.$element[dimension](this.$element[dimension]())[0].offsetHeight, this.$element.addClass("collapsing").removeClass("collapse").removeClass("in"), 
                this.transitioning = 1;
                var complete = function() {
                    this.transitioning = 0, this.$element.trigger("hidden.bs.collapse").removeClass("collapsing").addClass("collapse");
                };
                return $.support.transition ? void this.$element[dimension](0).one($.support.transition.end, $.proxy(complete, this)).emulateTransitionEnd(350) :complete.call(this);
            }
        }
    }, Collapse.prototype.toggle = function() {
        this[this.$element.hasClass("in") ? "hide" :"show"]();
    };
    var old = $.fn.collapse;
    $.fn.collapse = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.collapse"), options = $.extend({}, Collapse.DEFAULTS, $this.data(), "object" == typeof option && option);
            !data && options.toggle && "show" == option && (option = !option), data || $this.data("bs.collapse", data = new Collapse(this, options)), 
            "string" == typeof option && data[option]();
        });
    }, $.fn.collapse.Constructor = Collapse, $.fn.collapse.noConflict = function() {
        return $.fn.collapse = old, this;
    }, $(document).on("click.bs.collapse.data-api", "[data-toggle=collapse]", function(e) {
        var href, $this = $(this), target = $this.attr("data-target") || e.preventDefault() || (href = $this.attr("href")) && href.replace(/.*(?=#[^\s]+$)/, ""), $target = $(target), data = $target.data("bs.collapse"), option = data ? "toggle" :$this.data(), parent = $this.attr("data-parent"), $parent = parent && $(parent);
        data && data.transitioning || ($parent && $parent.find('[data-toggle=collapse][data-parent="' + parent + '"]').not($this).addClass("collapsed"), 
        $this[$target.hasClass("in") ? "addClass" :"removeClass"]("collapsed")), $target.collapse(option);
    });
}(jQuery), /* ========================================================================
 * Bootstrap: dropdown.js v3.1.0
 * http://getbootstrap.com/javascript/#dropdowns
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    function clearMenus(e) {
        $(backdrop).remove(), $(toggle).each(function() {
            var $parent = getParent($(this)), relatedTarget = {
                relatedTarget:this
            };
            $parent.hasClass("open") && ($parent.trigger(e = $.Event("hide.bs.dropdown", relatedTarget)), 
            e.isDefaultPrevented() || $parent.removeClass("open").trigger("hidden.bs.dropdown", relatedTarget));
        });
    }
    function getParent($this) {
        var selector = $this.attr("data-target");
        selector || (selector = $this.attr("href"), selector = selector && /#[A-Za-z]/.test(selector) && selector.replace(/.*(?=#[^\s]*$)/, ""));
        var $parent = selector && $(selector);
        return $parent && $parent.length ? $parent :$this.parent();
    }
    var backdrop = ".dropdown-backdrop", toggle = "[data-toggle=dropdown]", Dropdown = function(element) {
        $(element).on("click.bs.dropdown", this.toggle);
    };
    Dropdown.prototype.toggle = function(e) {
        var $this = $(this);
        if (!$this.is(".disabled, :disabled")) {
            var $parent = getParent($this), isActive = $parent.hasClass("open");
            if (clearMenus(), !isActive) {
                "ontouchstart" in document.documentElement && !$parent.closest(".navbar-nav").length && $('<div class="dropdown-backdrop"/>').insertAfter($(this)).on("click", clearMenus);
                var relatedTarget = {
                    relatedTarget:this
                };
                if ($parent.trigger(e = $.Event("show.bs.dropdown", relatedTarget)), e.isDefaultPrevented()) return;
                $parent.toggleClass("open").trigger("shown.bs.dropdown", relatedTarget), $this.focus();
            }
            return !1;
        }
    }, Dropdown.prototype.keydown = function(e) {
        if (/(38|40|27)/.test(e.keyCode)) {
            var $this = $(this);
            if (e.preventDefault(), e.stopPropagation(), !$this.is(".disabled, :disabled")) {
                var $parent = getParent($this), isActive = $parent.hasClass("open");
                if (!isActive || isActive && 27 == e.keyCode) return 27 == e.which && $parent.find(toggle).focus(), 
                $this.click();
                var desc = " li:not(.divider):visible a", $items = $parent.find("[role=menu]" + desc + ", [role=listbox]" + desc);
                if ($items.length) {
                    var index = $items.index($items.filter(":focus"));
                    38 == e.keyCode && index > 0 && index--, 40 == e.keyCode && index < $items.length - 1 && index++, 
                    ~index || (index = 0), $items.eq(index).focus();
                }
            }
        }
    };
    var old = $.fn.dropdown;
    $.fn.dropdown = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.dropdown");
            data || $this.data("bs.dropdown", data = new Dropdown(this)), "string" == typeof option && data[option].call($this);
        });
    }, $.fn.dropdown.Constructor = Dropdown, $.fn.dropdown.noConflict = function() {
        return $.fn.dropdown = old, this;
    }, $(document).on("click.bs.dropdown.data-api", clearMenus).on("click.bs.dropdown.data-api", ".dropdown form", function(e) {
        e.stopPropagation();
    }).on("click.bs.dropdown.data-api", toggle, Dropdown.prototype.toggle).on("keydown.bs.dropdown.data-api", toggle + ", [role=menu], [role=listbox]", Dropdown.prototype.keydown);
}(jQuery), /* ========================================================================
 * Bootstrap: modal.js v3.1.0
 * http://getbootstrap.com/javascript/#modals
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Modal = function(element, options) {
        this.options = options, this.$element = $(element), this.$backdrop = this.isShown = null, 
        this.options.remote && this.$element.find(".modal-content").load(this.options.remote, $.proxy(function() {
            this.$element.trigger("loaded.bs.modal");
        }, this));
    };
    Modal.DEFAULTS = {
        backdrop:!0,
        keyboard:!0,
        show:!0
    }, Modal.prototype.toggle = function(_relatedTarget) {
        return this[this.isShown ? "hide" :"show"](_relatedTarget);
    }, Modal.prototype.show = function(_relatedTarget) {
        var that = this, e = $.Event("show.bs.modal", {
            relatedTarget:_relatedTarget
        });
        this.$element.trigger(e), this.isShown || e.isDefaultPrevented() || (this.isShown = !0, 
        this.escape(), this.$element.on("click.dismiss.bs.modal", '[data-dismiss="modal"]', $.proxy(this.hide, this)), 
        this.backdrop(function() {
            var transition = $.support.transition && that.$element.hasClass("fade");
            that.$element.parent().length || that.$element.appendTo(document.body), that.$element.show().scrollTop(0), 
            transition && that.$element[0].offsetWidth, that.$element.addClass("in").attr("aria-hidden", !1), 
            that.enforceFocus();
            var e = $.Event("shown.bs.modal", {
                relatedTarget:_relatedTarget
            });
            transition ? that.$element.find(".modal-dialog").one($.support.transition.end, function() {
                that.$element.focus().trigger(e);
            }).emulateTransitionEnd(300) :that.$element.focus().trigger(e);
        }));
    }, Modal.prototype.hide = function(e) {
        e && e.preventDefault(), e = $.Event("hide.bs.modal"), this.$element.trigger(e), 
        this.isShown && !e.isDefaultPrevented() && (this.isShown = !1, this.escape(), $(document).off("focusin.bs.modal"), 
        this.$element.removeClass("in").attr("aria-hidden", !0).off("click.dismiss.bs.modal"), 
        $.support.transition && this.$element.hasClass("fade") ? this.$element.one($.support.transition.end, $.proxy(this.hideModal, this)).emulateTransitionEnd(300) :this.hideModal());
    }, Modal.prototype.enforceFocus = function() {
        $(document).off("focusin.bs.modal").on("focusin.bs.modal", $.proxy(function(e) {
            this.$element[0] === e.target || this.$element.has(e.target).length || this.$element.focus();
        }, this));
    }, Modal.prototype.escape = function() {
        this.isShown && this.options.keyboard ? this.$element.on("keyup.dismiss.bs.modal", $.proxy(function(e) {
            27 == e.which && this.hide();
        }, this)) :this.isShown || this.$element.off("keyup.dismiss.bs.modal");
    }, Modal.prototype.hideModal = function() {
        var that = this;
        this.$element.hide(), this.backdrop(function() {
            that.removeBackdrop(), that.$element.trigger("hidden.bs.modal");
        });
    }, Modal.prototype.removeBackdrop = function() {
        this.$backdrop && this.$backdrop.remove(), this.$backdrop = null;
    }, Modal.prototype.backdrop = function(callback) {
        var animate = this.$element.hasClass("fade") ? "fade" :"";
        if (this.isShown && this.options.backdrop) {
            var doAnimate = $.support.transition && animate;
            if (this.$backdrop = $('<div class="modal-backdrop ' + animate + '" />').appendTo(document.body), 
            this.$element.on("click.dismiss.bs.modal", $.proxy(function(e) {
                e.target === e.currentTarget && ("static" == this.options.backdrop ? this.$element[0].focus.call(this.$element[0]) :this.hide.call(this));
            }, this)), doAnimate && this.$backdrop[0].offsetWidth, this.$backdrop.addClass("in"), 
            !callback) return;
            doAnimate ? this.$backdrop.one($.support.transition.end, callback).emulateTransitionEnd(150) :callback();
        } else !this.isShown && this.$backdrop ? (this.$backdrop.removeClass("in"), $.support.transition && this.$element.hasClass("fade") ? this.$backdrop.one($.support.transition.end, callback).emulateTransitionEnd(150) :callback()) :callback && callback();
    };
    var old = $.fn.modal;
    $.fn.modal = function(option, _relatedTarget) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.modal"), options = $.extend({}, Modal.DEFAULTS, $this.data(), "object" == typeof option && option);
            data || $this.data("bs.modal", data = new Modal(this, options)), "string" == typeof option ? data[option](_relatedTarget) :options.show && data.show(_relatedTarget);
        });
    }, $.fn.modal.Constructor = Modal, $.fn.modal.noConflict = function() {
        return $.fn.modal = old, this;
    }, $(document).on("click.bs.modal.data-api", '[data-toggle="modal"]', function(e) {
        var $this = $(this), href = $this.attr("href"), $target = $($this.attr("data-target") || href && href.replace(/.*(?=#[^\s]+$)/, "")), option = $target.data("bs.modal") ? "toggle" :$.extend({
            remote:!/#/.test(href) && href
        }, $target.data(), $this.data());
        $this.is("a") && e.preventDefault(), $target.modal(option, this).one("hide", function() {
            $this.is(":visible") && $this.focus();
        });
    }), $(document).on("show.bs.modal", ".modal", function() {
        $(document.body).addClass("modal-open");
    }).on("hidden.bs.modal", ".modal", function() {
        $(document.body).removeClass("modal-open");
    });
}(jQuery), /* ========================================================================
 * Bootstrap: tooltip.js v3.1.0
 * http://getbootstrap.com/javascript/#tooltip
 * Inspired by the original jQuery.tipsy by Jason Frame
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Tooltip = function(element, options) {
        this.type = this.options = this.enabled = this.timeout = this.hoverState = this.$element = null, 
        this.init("tooltip", element, options);
    };
    Tooltip.DEFAULTS = {
        animation:!0,
        placement:"top",
        selector:!1,
        template:'<div class="tooltip"><div class="tooltip-arrow"></div><div class="tooltip-inner"></div></div>',
        trigger:"hover focus",
        title:"",
        delay:0,
        html:!1,
        container:!1
    }, Tooltip.prototype.init = function(type, element, options) {
        this.enabled = !0, this.type = type, this.$element = $(element), this.options = this.getOptions(options);
        for (var triggers = this.options.trigger.split(" "), i = triggers.length; i--; ) {
            var trigger = triggers[i];
            if ("click" == trigger) this.$element.on("click." + this.type, this.options.selector, $.proxy(this.toggle, this)); else if ("manual" != trigger) {
                var eventIn = "hover" == trigger ? "mouseenter" :"focusin", eventOut = "hover" == trigger ? "mouseleave" :"focusout";
                this.$element.on(eventIn + "." + this.type, this.options.selector, $.proxy(this.enter, this)), 
                this.$element.on(eventOut + "." + this.type, this.options.selector, $.proxy(this.leave, this));
            }
        }
        this.options.selector ? this._options = $.extend({}, this.options, {
            trigger:"manual",
            selector:""
        }) :this.fixTitle();
    }, Tooltip.prototype.getDefaults = function() {
        return Tooltip.DEFAULTS;
    }, Tooltip.prototype.getOptions = function(options) {
        return options = $.extend({}, this.getDefaults(), this.$element.data(), options), 
        options.delay && "number" == typeof options.delay && (options.delay = {
            show:options.delay,
            hide:options.delay
        }), options;
    }, Tooltip.prototype.getDelegateOptions = function() {
        var options = {}, defaults = this.getDefaults();
        return this._options && $.each(this._options, function(key, value) {
            defaults[key] != value && (options[key] = value);
        }), options;
    }, Tooltip.prototype.enter = function(obj) {
        var self = obj instanceof this.constructor ? obj :$(obj.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type);
        return clearTimeout(self.timeout), self.hoverState = "in", self.options.delay && self.options.delay.show ? void (self.timeout = setTimeout(function() {
            "in" == self.hoverState && self.show();
        }, self.options.delay.show)) :self.show();
    }, Tooltip.prototype.leave = function(obj) {
        var self = obj instanceof this.constructor ? obj :$(obj.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type);
        return clearTimeout(self.timeout), self.hoverState = "out", self.options.delay && self.options.delay.hide ? void (self.timeout = setTimeout(function() {
            "out" == self.hoverState && self.hide();
        }, self.options.delay.hide)) :self.hide();
    }, Tooltip.prototype.show = function() {
        var e = $.Event("show.bs." + this.type);
        if (this.hasContent() && this.enabled) {
            if (this.$element.trigger(e), e.isDefaultPrevented()) return;
            var that = this, $tip = this.tip();
            this.setContent(), this.options.animation && $tip.addClass("fade");
            var placement = "function" == typeof this.options.placement ? this.options.placement.call(this, $tip[0], this.$element[0]) :this.options.placement, autoToken = /\s?auto?\s?/i, autoPlace = autoToken.test(placement);
            autoPlace && (placement = placement.replace(autoToken, "") || "top"), $tip.detach().css({
                top:0,
                left:0,
                display:"block"
            }).addClass(placement), this.options.container ? $tip.appendTo(this.options.container) :$tip.insertAfter(this.$element);
            var pos = this.getPosition(), actualWidth = $tip[0].offsetWidth, actualHeight = $tip[0].offsetHeight;
            if (autoPlace) {
                var $parent = this.$element.parent(), orgPlacement = placement, docScroll = document.documentElement.scrollTop || document.body.scrollTop, parentWidth = "body" == this.options.container ? window.innerWidth :$parent.outerWidth(), parentHeight = "body" == this.options.container ? window.innerHeight :$parent.outerHeight(), parentLeft = "body" == this.options.container ? 0 :$parent.offset().left;
                placement = "bottom" == placement && pos.top + pos.height + actualHeight - docScroll > parentHeight ? "top" :"top" == placement && pos.top - docScroll - actualHeight < 0 ? "bottom" :"right" == placement && pos.right + actualWidth > parentWidth ? "left" :"left" == placement && pos.left - actualWidth < parentLeft ? "right" :placement, 
                $tip.removeClass(orgPlacement).addClass(placement);
            }
            var calculatedOffset = this.getCalculatedOffset(placement, pos, actualWidth, actualHeight);
            this.applyPlacement(calculatedOffset, placement), this.hoverState = null;
            var complete = function() {
                that.$element.trigger("shown.bs." + that.type);
            };
            $.support.transition && this.$tip.hasClass("fade") ? $tip.one($.support.transition.end, complete).emulateTransitionEnd(150) :complete();
        }
    }, Tooltip.prototype.applyPlacement = function(offset, placement) {
        var replace, $tip = this.tip(), width = $tip[0].offsetWidth, height = $tip[0].offsetHeight, marginTop = parseInt($tip.css("margin-top"), 10), marginLeft = parseInt($tip.css("margin-left"), 10);
        isNaN(marginTop) && (marginTop = 0), isNaN(marginLeft) && (marginLeft = 0), offset.top = offset.top + marginTop, 
        offset.left = offset.left + marginLeft, $.offset.setOffset($tip[0], $.extend({
            using:function(props) {
                $tip.css({
                    top:Math.round(props.top),
                    left:Math.round(props.left)
                });
            }
        }, offset), 0), $tip.addClass("in");
        var actualWidth = $tip[0].offsetWidth, actualHeight = $tip[0].offsetHeight;
        if ("top" == placement && actualHeight != height && (replace = !0, offset.top = offset.top + height - actualHeight), 
        /bottom|top/.test(placement)) {
            var delta = 0;
            offset.left < 0 && (delta = -2 * offset.left, offset.left = 0, $tip.offset(offset), 
            actualWidth = $tip[0].offsetWidth, actualHeight = $tip[0].offsetHeight), this.replaceArrow(delta - width + actualWidth, actualWidth, "left");
        } else this.replaceArrow(actualHeight - height, actualHeight, "top");
        replace && $tip.offset(offset);
    }, Tooltip.prototype.replaceArrow = function(delta, dimension, position) {
        this.arrow().css(position, delta ? 50 * (1 - delta / dimension) + "%" :"");
    }, Tooltip.prototype.setContent = function() {
        var $tip = this.tip(), title = this.getTitle();
        $tip.find(".tooltip-inner")[this.options.html ? "html" :"text"](title), $tip.removeClass("fade in top bottom left right");
    }, Tooltip.prototype.hide = function() {
        function complete() {
            "in" != that.hoverState && $tip.detach(), that.$element.trigger("hidden.bs." + that.type);
        }
        var that = this, $tip = this.tip(), e = $.Event("hide.bs." + this.type);
        return this.$element.trigger(e), e.isDefaultPrevented() ? void 0 :($tip.removeClass("in"), 
        $.support.transition && this.$tip.hasClass("fade") ? $tip.one($.support.transition.end, complete).emulateTransitionEnd(150) :complete(), 
        this.hoverState = null, this);
    }, Tooltip.prototype.fixTitle = function() {
        var $e = this.$element;
        ($e.attr("title") || "string" != typeof $e.attr("data-original-title")) && $e.attr("data-original-title", $e.attr("title") || "").attr("title", "");
    }, Tooltip.prototype.hasContent = function() {
        return this.getTitle();
    }, Tooltip.prototype.getPosition = function() {
        var el = this.$element[0];
        return $.extend({}, "function" == typeof el.getBoundingClientRect ? el.getBoundingClientRect() :{
            width:el.offsetWidth,
            height:el.offsetHeight
        }, this.$element.offset());
    }, Tooltip.prototype.getCalculatedOffset = function(placement, pos, actualWidth, actualHeight) {
        return "bottom" == placement ? {
            top:pos.top + pos.height,
            left:pos.left + pos.width / 2 - actualWidth / 2
        } :"top" == placement ? {
            top:pos.top - actualHeight,
            left:pos.left + pos.width / 2 - actualWidth / 2
        } :"left" == placement ? {
            top:pos.top + pos.height / 2 - actualHeight / 2,
            left:pos.left - actualWidth
        } :{
            top:pos.top + pos.height / 2 - actualHeight / 2,
            left:pos.left + pos.width
        };
    }, Tooltip.prototype.getTitle = function() {
        var title, $e = this.$element, o = this.options;
        return title = $e.attr("data-original-title") || ("function" == typeof o.title ? o.title.call($e[0]) :o.title);
    }, Tooltip.prototype.tip = function() {
        return this.$tip = this.$tip || $(this.options.template);
    }, Tooltip.prototype.arrow = function() {
        return this.$arrow = this.$arrow || this.tip().find(".tooltip-arrow");
    }, Tooltip.prototype.validate = function() {
        this.$element[0].parentNode || (this.hide(), this.$element = null, this.options = null);
    }, Tooltip.prototype.enable = function() {
        this.enabled = !0;
    }, Tooltip.prototype.disable = function() {
        this.enabled = !1;
    }, Tooltip.prototype.toggleEnabled = function() {
        this.enabled = !this.enabled;
    }, Tooltip.prototype.toggle = function(e) {
        var self = e ? $(e.currentTarget)[this.type](this.getDelegateOptions()).data("bs." + this.type) :this;
        self.tip().hasClass("in") ? self.leave(self) :self.enter(self);
    }, Tooltip.prototype.destroy = function() {
        clearTimeout(this.timeout), this.hide().$element.off("." + this.type).removeData("bs." + this.type);
    };
    var old = $.fn.tooltip;
    $.fn.tooltip = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.tooltip"), options = "object" == typeof option && option;
            (data || "destroy" != option) && (data || $this.data("bs.tooltip", data = new Tooltip(this, options)), 
            "string" == typeof option && data[option]());
        });
    }, $.fn.tooltip.Constructor = Tooltip, $.fn.tooltip.noConflict = function() {
        return $.fn.tooltip = old, this;
    };
}(jQuery), /* ========================================================================
 * Bootstrap: popover.js v3.1.0
 * http://getbootstrap.com/javascript/#popovers
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Popover = function(element, options) {
        this.init("popover", element, options);
    };
    if (!$.fn.tooltip) throw new Error("Popover requires tooltip.js");
    Popover.DEFAULTS = $.extend({}, $.fn.tooltip.Constructor.DEFAULTS, {
        placement:"right",
        trigger:"click",
        content:"",
        template:'<div class="popover"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div></div>'
    }), Popover.prototype = $.extend({}, $.fn.tooltip.Constructor.prototype), Popover.prototype.constructor = Popover, 
    Popover.prototype.getDefaults = function() {
        return Popover.DEFAULTS;
    }, Popover.prototype.setContent = function() {
        var $tip = this.tip(), title = this.getTitle(), content = this.getContent();
        $tip.find(".popover-title")[this.options.html ? "html" :"text"](title), $tip.find(".popover-content")[this.options.html ? "string" == typeof content ? "html" :"append" :"text"](content), 
        $tip.removeClass("fade top bottom left right in"), $tip.find(".popover-title").html() || $tip.find(".popover-title").hide();
    }, Popover.prototype.hasContent = function() {
        return this.getTitle() || this.getContent();
    }, Popover.prototype.getContent = function() {
        var $e = this.$element, o = this.options;
        return $e.attr("data-content") || ("function" == typeof o.content ? o.content.call($e[0]) :o.content);
    }, Popover.prototype.arrow = function() {
        return this.$arrow = this.$arrow || this.tip().find(".arrow");
    }, Popover.prototype.tip = function() {
        return this.$tip || (this.$tip = $(this.options.template)), this.$tip;
    };
    var old = $.fn.popover;
    $.fn.popover = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.popover"), options = "object" == typeof option && option;
            (data || "destroy" != option) && (data || $this.data("bs.popover", data = new Popover(this, options)), 
            "string" == typeof option && data[option]());
        });
    }, $.fn.popover.Constructor = Popover, $.fn.popover.noConflict = function() {
        return $.fn.popover = old, this;
    };
}(jQuery), /* ========================================================================
 * Bootstrap: scrollspy.js v3.1.0
 * http://getbootstrap.com/javascript/#scrollspy
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    function ScrollSpy(element, options) {
        var href, process = $.proxy(this.process, this);
        this.$element = $($(element).is("body") ? window :element), this.$body = $("body"), 
        this.$scrollElement = this.$element.on("scroll.bs.scroll-spy.data-api", process), 
        this.options = $.extend({}, ScrollSpy.DEFAULTS, options), this.selector = (this.options.target || (href = $(element).attr("href")) && href.replace(/.*(?=#[^\s]+$)/, "") || "") + " .nav li > a", 
        this.offsets = $([]), this.targets = $([]), this.activeTarget = null, this.refresh(), 
        this.process();
    }
    ScrollSpy.DEFAULTS = {
        offset:10
    }, ScrollSpy.prototype.refresh = function() {
        var offsetMethod = this.$element[0] == window ? "offset" :"position";
        this.offsets = $([]), this.targets = $([]);
        {
            var self = this;
            this.$body.find(this.selector).map(function() {
                var $el = $(this), href = $el.data("target") || $el.attr("href"), $href = /^#./.test(href) && $(href);
                return $href && $href.length && $href.is(":visible") && [ [ $href[offsetMethod]().top + (!$.isWindow(self.$scrollElement.get(0)) && self.$scrollElement.scrollTop()), href ] ] || null;
            }).sort(function(a, b) {
                return a[0] - b[0];
            }).each(function() {
                self.offsets.push(this[0]), self.targets.push(this[1]);
            });
        }
    }, ScrollSpy.prototype.process = function() {
        var i, scrollTop = this.$scrollElement.scrollTop() + this.options.offset, scrollHeight = this.$scrollElement[0].scrollHeight || this.$body[0].scrollHeight, maxScroll = scrollHeight - this.$scrollElement.height(), offsets = this.offsets, targets = this.targets, activeTarget = this.activeTarget;
        if (scrollTop >= maxScroll) return activeTarget != (i = targets.last()[0]) && this.activate(i);
        if (activeTarget && scrollTop <= offsets[0]) return activeTarget != (i = targets[0]) && this.activate(i);
        for (i = offsets.length; i--; ) activeTarget != targets[i] && scrollTop >= offsets[i] && (!offsets[i + 1] || scrollTop <= offsets[i + 1]) && this.activate(targets[i]);
    }, ScrollSpy.prototype.activate = function(target) {
        this.activeTarget = target, $(this.selector).parentsUntil(this.options.target, ".active").removeClass("active");
        var selector = this.selector + '[data-target="' + target + '"],' + this.selector + '[href="' + target + '"]', active = $(selector).parents("li").addClass("active");
        active.parent(".dropdown-menu").length && (active = active.closest("li.dropdown").addClass("active")), 
        active.trigger("activate.bs.scrollspy");
    };
    var old = $.fn.scrollspy;
    $.fn.scrollspy = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.scrollspy"), options = "object" == typeof option && option;
            data || $this.data("bs.scrollspy", data = new ScrollSpy(this, options)), "string" == typeof option && data[option]();
        });
    }, $.fn.scrollspy.Constructor = ScrollSpy, $.fn.scrollspy.noConflict = function() {
        return $.fn.scrollspy = old, this;
    }, $(window).on("load", function() {
        $('[data-spy="scroll"]').each(function() {
            var $spy = $(this);
            $spy.scrollspy($spy.data());
        });
    });
}(jQuery), /* ========================================================================
 * Bootstrap: tab.js v3.1.0
 * http://getbootstrap.com/javascript/#tabs
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Tab = function(element) {
        this.element = $(element);
    };
    Tab.prototype.show = function() {
        var $this = this.element, $ul = $this.closest("ul:not(.dropdown-menu)"), selector = $this.data("target");
        if (selector || (selector = $this.attr("href"), selector = selector && selector.replace(/.*(?=#[^\s]*$)/, "")), 
        !$this.parent("li").hasClass("active")) {
            var previous = $ul.find(".active:last a")[0], e = $.Event("show.bs.tab", {
                relatedTarget:previous
            });
            if ($this.trigger(e), !e.isDefaultPrevented()) {
                var $target = $(selector);
                this.activate($this.parent("li"), $ul), this.activate($target, $target.parent(), function() {
                    $this.trigger({
                        type:"shown.bs.tab",
                        relatedTarget:previous
                    });
                });
            }
        }
    }, Tab.prototype.activate = function(element, container, callback) {
        function next() {
            $active.removeClass("active").find("> .dropdown-menu > .active").removeClass("active"), 
            element.addClass("active"), transition ? (element[0].offsetWidth, element.addClass("in")) :element.removeClass("fade"), 
            element.parent(".dropdown-menu") && element.closest("li.dropdown").addClass("active"), 
            callback && callback();
        }
        var $active = container.find("> .active"), transition = callback && $.support.transition && $active.hasClass("fade");
        transition ? $active.one($.support.transition.end, next).emulateTransitionEnd(150) :next(), 
        $active.removeClass("in");
    };
    var old = $.fn.tab;
    $.fn.tab = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.tab");
            data || $this.data("bs.tab", data = new Tab(this)), "string" == typeof option && data[option]();
        });
    }, $.fn.tab.Constructor = Tab, $.fn.tab.noConflict = function() {
        return $.fn.tab = old, this;
    }, $(document).on("click.bs.tab.data-api", '[data-toggle="tab"], [data-toggle="pill"]', function(e) {
        e.preventDefault(), $(this).tab("show");
    });
}(jQuery), /* ========================================================================
 * Bootstrap: affix.js v3.1.0
 * http://getbootstrap.com/javascript/#affix
 * ========================================================================
 * Copyright 2011-2014 Twitter, Inc.
 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 * ======================================================================== */
+function($) {
    "use strict";
    var Affix = function(element, options) {
        this.options = $.extend({}, Affix.DEFAULTS, options), this.$window = $(window).on("scroll.bs.affix.data-api", $.proxy(this.checkPosition, this)).on("click.bs.affix.data-api", $.proxy(this.checkPositionWithEventLoop, this)), 
        this.$element = $(element), this.affixed = this.unpin = this.pinnedOffset = null, 
        this.checkPosition();
    };
    Affix.RESET = "affix affix-top affix-bottom", Affix.DEFAULTS = {
        offset:0
    }, Affix.prototype.getPinnedOffset = function() {
        if (this.pinnedOffset) return this.pinnedOffset;
        this.$element.removeClass(Affix.RESET).addClass("affix");
        var scrollTop = this.$window.scrollTop(), position = this.$element.offset();
        return this.pinnedOffset = position.top - scrollTop;
    }, Affix.prototype.checkPositionWithEventLoop = function() {
        setTimeout($.proxy(this.checkPosition, this), 1);
    }, Affix.prototype.checkPosition = function() {
        if (this.$element.is(":visible")) {
            var scrollHeight = $(document).height(), scrollTop = this.$window.scrollTop(), position = this.$element.offset(), offset = this.options.offset, offsetTop = offset.top, offsetBottom = offset.bottom;
            "top" == this.affixed && (position.top += scrollTop), "object" != typeof offset && (offsetBottom = offsetTop = offset), 
            "function" == typeof offsetTop && (offsetTop = offset.top(this.$element)), "function" == typeof offsetBottom && (offsetBottom = offset.bottom(this.$element));
            var affix = null != this.unpin && scrollTop + this.unpin <= position.top ? !1 :null != offsetBottom && position.top + this.$element.height() >= scrollHeight - offsetBottom ? "bottom" :null != offsetTop && offsetTop >= scrollTop ? "top" :!1;
            if (this.affixed !== affix) {
                this.unpin && this.$element.css("top", "");
                var affixType = "affix" + (affix ? "-" + affix :""), e = $.Event(affixType + ".bs.affix");
                this.$element.trigger(e), e.isDefaultPrevented() || (this.affixed = affix, this.unpin = "bottom" == affix ? this.getPinnedOffset() :null, 
                this.$element.removeClass(Affix.RESET).addClass(affixType).trigger($.Event(affixType.replace("affix", "affixed"))), 
                "bottom" == affix && this.$element.offset({
                    top:scrollHeight - offsetBottom - this.$element.height()
                }));
            }
        }
    };
    var old = $.fn.affix;
    $.fn.affix = function(option) {
        return this.each(function() {
            var $this = $(this), data = $this.data("bs.affix"), options = "object" == typeof option && option;
            data || $this.data("bs.affix", data = new Affix(this, options)), "string" == typeof option && data[option]();
        });
    }, $.fn.affix.Constructor = Affix, $.fn.affix.noConflict = function() {
        return $.fn.affix = old, this;
    }, $(window).on("load", function() {
        $('[data-spy="affix"]').each(function() {
            var $spy = $(this), data = $spy.data();
            data.offset = data.offset || {}, data.offsetBottom && (data.offset.bottom = data.offsetBottom), 
            data.offsetTop && (data.offset.top = data.offsetTop), $spy.affix(data);
        });
    });
}(jQuery), function() {
    var CSRFToken, allowLinkExtensions, anchoredLink, browserCompatibleDocumentParser, browserIsntBuggy, browserSupportsCustomEvents, browserSupportsPushState, browserSupportsTurbolinks, cacheCurrentPage, cacheSize, changePage, constrainPageCacheTo, createDocument, crossOriginLink, currentState, enableTransitionCache, executeScriptTags, extractLink, extractTitleAndBody, fetch, fetchHistory, fetchReplacement, handleClick, historyStateIsDefined, htmlExtensions, ignoreClick, initializeTurbolinks, installClickHandlerLast, installDocumentReadyPageEventTriggers, installHistoryChangeHandler, installJqueryAjaxSuccessPageUpdateTrigger, loadedAssets, noTurbolink, nonHtmlLink, nonStandardClick, pageCache, pageChangePrevented, pagesCached, popCookie, processResponse, recallScrollPosition, referer, reflectNewUrl, reflectRedirectedUrl, rememberCurrentState, rememberCurrentUrl, rememberReferer, removeHash, removeHashForIE10compatiblity, removeNoscriptTags, requestMethodIsSafe, resetScrollPosition, targetLink, transitionCacheEnabled, transitionCacheFor, triggerEvent, visit, xhr, _ref, __indexOf = [].indexOf || function(item) {
        for (var i = 0, l = this.length; l > i; i++) if (i in this && this[i] === item) return i;
        return -1;
    }, __slice = [].slice;
    pageCache = {}, cacheSize = 10, transitionCacheEnabled = !1, currentState = null, 
    loadedAssets = null, htmlExtensions = [ "html" ], referer = null, createDocument = null, 
    xhr = null, fetch = function(url) {
        var cachedPage;
        return rememberReferer(), cacheCurrentPage(), reflectNewUrl(url), transitionCacheEnabled && (cachedPage = transitionCacheFor(url)) ? (fetchHistory(cachedPage), 
        fetchReplacement(url)) :fetchReplacement(url, resetScrollPosition);
    }, transitionCacheFor = function(url) {
        var cachedPage;
        return cachedPage = pageCache[url], cachedPage && !cachedPage.transitionCacheDisabled ? cachedPage :void 0;
    }, enableTransitionCache = function(enable) {
        return null == enable && (enable = !0), transitionCacheEnabled = enable;
    }, fetchReplacement = function(url, onLoadFunction) {
        return null == onLoadFunction && (onLoadFunction = function() {
            return function() {};
        }(this)), triggerEvent("page:fetch", {
            url:url
        }), null != xhr && xhr.abort(), xhr = new XMLHttpRequest(), xhr.open("GET", removeHashForIE10compatiblity(url), !0), 
        xhr.setRequestHeader("Accept", "text/html, application/xhtml+xml, application/xml"), 
        xhr.setRequestHeader("X-XHR-Referer", referer), xhr.onload = function() {
            var doc;
            return triggerEvent("page:receive"), (doc = processResponse()) ? (changePage.apply(null, extractTitleAndBody(doc)), 
            reflectRedirectedUrl(), onLoadFunction(), triggerEvent("page:load")) :document.location.href = url;
        }, xhr.onloadend = function() {
            return xhr = null;
        }, xhr.onerror = function() {
            return document.location.href = url;
        }, xhr.send();
    }, fetchHistory = function(cachedPage) {
        return null != xhr && xhr.abort(), changePage(cachedPage.title, cachedPage.body), 
        recallScrollPosition(cachedPage), triggerEvent("page:restore");
    }, cacheCurrentPage = function() {
        return pageCache[currentState.url] = {
            url:document.location.href,
            body:document.body,
            title:document.title,
            positionY:window.pageYOffset,
            positionX:window.pageXOffset,
            cachedAt:new Date().getTime(),
            transitionCacheDisabled:null != document.querySelector("[data-no-transition-cache]")
        }, constrainPageCacheTo(cacheSize);
    }, pagesCached = function(size) {
        return null == size && (size = cacheSize), /^[\d]+$/.test(size) ? cacheSize = parseInt(size) :void 0;
    }, constrainPageCacheTo = function(limit) {
        var cacheTimesRecentFirst, key, pageCacheKeys, _i, _len, _results;
        for (pageCacheKeys = Object.keys(pageCache), cacheTimesRecentFirst = pageCacheKeys.map(function(url) {
            return pageCache[url].cachedAt;
        }).sort(function(a, b) {
            return b - a;
        }), _results = [], _i = 0, _len = pageCacheKeys.length; _len > _i; _i++) key = pageCacheKeys[_i], 
        pageCache[key].cachedAt <= cacheTimesRecentFirst[limit] && (triggerEvent("page:expire", pageCache[key]), 
        _results.push(delete pageCache[key]));
        return _results;
    }, changePage = function(title, body, csrfToken, runScripts) {
        return document.title = title, document.documentElement.replaceChild(body, document.body), 
        null != csrfToken && CSRFToken.update(csrfToken), runScripts && executeScriptTags(), 
        currentState = window.history.state, triggerEvent("page:change"), triggerEvent("page:update");
    }, executeScriptTags = function() {
        var attr, copy, nextSibling, parentNode, script, scripts, _i, _j, _len, _len1, _ref, _ref1;
        for (scripts = Array.prototype.slice.call(document.body.querySelectorAll('script:not([data-turbolinks-eval="false"])')), 
        _i = 0, _len = scripts.length; _len > _i; _i++) if (script = scripts[_i], "" === (_ref = script.type) || "text/javascript" === _ref) {
            for (copy = document.createElement("script"), _ref1 = script.attributes, _j = 0, 
            _len1 = _ref1.length; _len1 > _j; _j++) attr = _ref1[_j], copy.setAttribute(attr.name, attr.value);
            copy.appendChild(document.createTextNode(script.innerHTML)), parentNode = script.parentNode, 
            nextSibling = script.nextSibling, parentNode.removeChild(script), parentNode.insertBefore(copy, nextSibling);
        }
    }, removeNoscriptTags = function(node) {
        return node.innerHTML = node.innerHTML.replace(/<noscript[\S\s]*?<\/noscript>/gi, ""), 
        node;
    }, reflectNewUrl = function(url) {
        return url !== referer ? window.history.pushState({
            turbolinks:!0,
            url:url
        }, "", url) :void 0;
    }, reflectRedirectedUrl = function() {
        var location, preservedHash;
        return (location = xhr.getResponseHeader("X-XHR-Redirected-To")) ? (preservedHash = removeHash(location) === location ? document.location.hash :"", 
        window.history.replaceState(currentState, "", location + preservedHash)) :void 0;
    }, rememberReferer = function() {
        return referer = document.location.href;
    }, rememberCurrentUrl = function() {
        return window.history.replaceState({
            turbolinks:!0,
            url:document.location.href
        }, "", document.location.href);
    }, rememberCurrentState = function() {
        return currentState = window.history.state;
    }, recallScrollPosition = function(page) {
        return window.scrollTo(page.positionX, page.positionY);
    }, resetScrollPosition = function() {
        return document.location.hash ? document.location.href = document.location.href :window.scrollTo(0, 0);
    }, removeHashForIE10compatiblity = function(url) {
        return removeHash(url);
    }, removeHash = function(url) {
        var link;
        return link = url, null == url.href && (link = document.createElement("A"), link.href = url), 
        link.href.replace(link.hash, "");
    }, popCookie = function(name) {
        var value, _ref;
        return value = (null != (_ref = document.cookie.match(new RegExp(name + "=(\\w+)"))) ? _ref[1].toUpperCase() :void 0) || "", 
        document.cookie = name + "=; expires=Thu, 01-Jan-70 00:00:01 GMT; path=/", value;
    }, triggerEvent = function(name, data) {
        var event;
        return event = document.createEvent("Events"), data && (event.data = data), event.initEvent(name, !0, !0), 
        document.dispatchEvent(event);
    }, pageChangePrevented = function() {
        return !triggerEvent("page:before-change");
    }, processResponse = function() {
        var assetsChanged, clientOrServerError, doc, extractTrackAssets, intersection, validContent;
        return clientOrServerError = function() {
            var _ref;
            return 400 <= (_ref = xhr.status) && 600 > _ref;
        }, validContent = function() {
            return xhr.getResponseHeader("Content-Type").match(/^(?:text\/html|application\/xhtml\+xml|application\/xml)(?:;|$)/);
        }, extractTrackAssets = function(doc) {
            var node, _i, _len, _ref, _results;
            for (_ref = doc.head.childNodes, _results = [], _i = 0, _len = _ref.length; _len > _i; _i++) node = _ref[_i], 
            null != ("function" == typeof node.getAttribute ? node.getAttribute("data-turbolinks-track") :void 0) && _results.push(node.getAttribute("src") || node.getAttribute("href"));
            return _results;
        }, assetsChanged = function(doc) {
            var fetchedAssets;
            return loadedAssets || (loadedAssets = extractTrackAssets(document)), fetchedAssets = extractTrackAssets(doc), 
            fetchedAssets.length !== loadedAssets.length || intersection(fetchedAssets, loadedAssets).length !== loadedAssets.length;
        }, intersection = function(a, b) {
            var value, _i, _len, _ref, _results;
            for (a.length > b.length && (_ref = [ b, a ], a = _ref[0], b = _ref[1]), _results = [], 
            _i = 0, _len = a.length; _len > _i; _i++) value = a[_i], __indexOf.call(b, value) >= 0 && _results.push(value);
            return _results;
        }, !clientOrServerError() && validContent() && (doc = createDocument(xhr.responseText), 
        doc && !assetsChanged(doc)) ? doc :void 0;
    }, extractTitleAndBody = function(doc) {
        var title;
        return title = doc.querySelector("title"), [ null != title ? title.textContent :void 0, removeNoscriptTags(doc.body), CSRFToken.get(doc).token, "runScripts" ];
    }, CSRFToken = {
        get:function(doc) {
            var tag;
            return null == doc && (doc = document), {
                node:tag = doc.querySelector('meta[name="csrf-token"]'),
                token:null != tag ? "function" == typeof tag.getAttribute ? tag.getAttribute("content") :void 0 :void 0
            };
        },
        update:function(latest) {
            var current;
            return current = this.get(), null != current.token && null != latest && current.token !== latest ? current.node.setAttribute("content", latest) :void 0;
        }
    }, browserCompatibleDocumentParser = function() {
        var createDocumentUsingDOM, createDocumentUsingParser, createDocumentUsingWrite, e, testDoc, _ref;
        createDocumentUsingParser = function(html) {
            return new DOMParser().parseFromString(html, "text/html");
        }, createDocumentUsingDOM = function(html) {
            var doc;
            return doc = document.implementation.createHTMLDocument(""), doc.documentElement.innerHTML = html, 
            doc;
        }, createDocumentUsingWrite = function(html) {
            var doc;
            return doc = document.implementation.createHTMLDocument(""), doc.open("replace"), 
            doc.write(html), doc.close(), doc;
        };
        try {
            if (window.DOMParser) return testDoc = createDocumentUsingParser("<html><body><p>test"), 
            createDocumentUsingParser;
        } catch (_error) {
            return e = _error, testDoc = createDocumentUsingDOM("<html><body><p>test"), createDocumentUsingDOM;
        } finally {
            if (1 !== (null != testDoc ? null != (_ref = testDoc.body) ? _ref.childNodes.length :void 0 :void 0)) return createDocumentUsingWrite;
        }
    }, installClickHandlerLast = function(event) {
        return event.defaultPrevented ? void 0 :(document.removeEventListener("click", handleClick, !1), 
        document.addEventListener("click", handleClick, !1));
    }, handleClick = function(event) {
        var link;
        return event.defaultPrevented || (link = extractLink(event), "A" !== link.nodeName || ignoreClick(event, link)) ? void 0 :(pageChangePrevented() || visit(link.href), 
        event.preventDefault());
    }, extractLink = function(event) {
        var link;
        for (link = event.target; link.parentNode && "A" !== link.nodeName; ) link = link.parentNode;
        return link;
    }, crossOriginLink = function(link) {
        return location.protocol !== link.protocol || location.host !== link.host;
    }, anchoredLink = function(link) {
        return (link.hash && removeHash(link)) === removeHash(location) || link.href === location.href + "#";
    }, nonHtmlLink = function(link) {
        var url;
        return url = removeHash(link), url.match(/\.[a-z]+(\?.*)?$/g) && !url.match(new RegExp("\\.(?:" + htmlExtensions.join("|") + ")?(\\?.*)?$", "g"));
    }, noTurbolink = function(link) {
        for (var ignore; !ignore && link !== document; ) ignore = null != link.getAttribute("data-no-turbolink"), 
        link = link.parentNode;
        return ignore;
    }, targetLink = function(link) {
        return 0 !== link.target.length;
    }, nonStandardClick = function(event) {
        return event.which > 1 || event.metaKey || event.ctrlKey || event.shiftKey || event.altKey;
    }, ignoreClick = function(event, link) {
        return crossOriginLink(link) || anchoredLink(link) || nonHtmlLink(link) || noTurbolink(link) || targetLink(link) || nonStandardClick(event);
    }, allowLinkExtensions = function() {
        var extension, extensions, _i, _len;
        for (extensions = 1 <= arguments.length ? __slice.call(arguments, 0) :[], _i = 0, 
        _len = extensions.length; _len > _i; _i++) extension = extensions[_i], htmlExtensions.push(extension);
        return htmlExtensions;
    }, installDocumentReadyPageEventTriggers = function() {
        return document.addEventListener("DOMContentLoaded", function() {
            return triggerEvent("page:change"), triggerEvent("page:update");
        }, !0);
    }, installJqueryAjaxSuccessPageUpdateTrigger = function() {
        return "undefined" != typeof jQuery ? jQuery(document).on("ajaxSuccess", function(event, xhr) {
            return jQuery.trim(xhr.responseText) ? triggerEvent("page:update") :void 0;
        }) :void 0;
    }, installHistoryChangeHandler = function(event) {
        var cachedPage, _ref;
        return (null != (_ref = event.state) ? _ref.turbolinks :void 0) ? (cachedPage = pageCache[event.state.url]) ? (cacheCurrentPage(), 
        fetchHistory(cachedPage)) :visit(event.target.location.href) :void 0;
    }, initializeTurbolinks = function() {
        return rememberCurrentUrl(), rememberCurrentState(), createDocument = browserCompatibleDocumentParser(), 
        document.addEventListener("click", installClickHandlerLast, !0), window.addEventListener("popstate", installHistoryChangeHandler, !1);
    }, historyStateIsDefined = void 0 !== window.history.state || navigator.userAgent.match(/Firefox\/26/), 
    browserSupportsPushState = window.history && window.history.pushState && window.history.replaceState && historyStateIsDefined, 
    browserIsntBuggy = !navigator.userAgent.match(/CriOS\//), requestMethodIsSafe = "GET" === (_ref = popCookie("request_method")) || "" === _ref, 
    browserSupportsTurbolinks = browserSupportsPushState && browserIsntBuggy && requestMethodIsSafe, 
    browserSupportsCustomEvents = document.addEventListener && document.createEvent, 
    browserSupportsCustomEvents && (installDocumentReadyPageEventTriggers(), installJqueryAjaxSuccessPageUpdateTrigger()), 
    browserSupportsTurbolinks ? (visit = fetch, initializeTurbolinks()) :visit = function(url) {
        return document.location.href = url;
    }, this.Turbolinks = {
        visit:visit,
        pagesCached:pagesCached,
        enableTransitionCache:enableTransitionCache,
        allowLinkExtensions:allowLinkExtensions,
        supported:browserSupportsTurbolinks
    };
}.call(this), function($) {
    var cocoon_element_counter = 0, create_new_id = function() {
        return new Date().getTime() + cocoon_element_counter++;
    }, newcontent_braced = function(id) {
        return "[" + id + "]$1";
    }, newcontent_underscord = function(id) {
        return "_" + id + "_$1";
    };
    $(document).on("click", ".add_fields", function(e) {
        e.preventDefault();
        var $this = $(this), assoc = $this.data("association"), assocs = $this.data("associations"), content = $this.data("association-insertion-template"), insertionMethod = $this.data("association-insertion-method") || $this.data("association-insertion-position") || "before", insertionNode = $this.data("association-insertion-node"), insertionTraversal = $this.data("association-insertion-traversal"), count = parseInt($this.data("count"), 10), regexp_braced = new RegExp("\\[new_" + assoc + "\\](.*?\\s)", "g"), regexp_underscord = new RegExp("_new_" + assoc + "_(\\w*)", "g"), new_id = create_new_id(), new_content = content.replace(regexp_braced, newcontent_braced(new_id)), new_contents = [];
        for (new_content == content && (regexp_braced = new RegExp("\\[new_" + assocs + "\\](.*?\\s)", "g"), 
        regexp_underscord = new RegExp("_new_" + assocs + "_(\\w*)", "g"), new_content = content.replace(regexp_braced, newcontent_braced(new_id))), 
        new_content = new_content.replace(regexp_underscord, newcontent_underscord(new_id)), 
        new_contents = [ new_content ], count = isNaN(count) ? 1 :Math.max(count, 1), count -= 1; count; ) new_id = create_new_id(), 
        new_content = content.replace(regexp_braced, newcontent_braced(new_id)), new_content = new_content.replace(regexp_underscord, newcontent_underscord(new_id)), 
        new_contents.push(new_content), count -= 1;
        insertionNode = insertionNode ? insertionTraversal ? $this[insertionTraversal](insertionNode) :"this" == insertionNode ? $this :$(insertionNode) :$this.parent();
        for (var i in new_contents) {
            var contentNode = $(new_contents[i]);
            insertionNode.trigger("cocoon:before-insert", [ contentNode ]);
            {
                insertionNode[insertionMethod](contentNode);
            }
            insertionNode.trigger("cocoon:after-insert", [ contentNode ]);
        }
    }), $(document).on("click", ".remove_fields.dynamic, .remove_fields.existing", function(e) {
        var $this = $(this), wrapper_class = $this.data("wrapper-class") || "nested-fields", node_to_delete = $this.closest("." + wrapper_class), trigger_node = node_to_delete.parent();
        e.preventDefault(), trigger_node.trigger("cocoon:before-remove", [ node_to_delete ]);
        var timeout = trigger_node.data("remove-timeout") || 0;
        setTimeout(function() {
            $this.hasClass("dynamic") ? node_to_delete.remove() :($this.prev("input[type=hidden]").val("1"), 
            node_to_delete.hide()), trigger_node.trigger("cocoon:after-remove", [ node_to_delete ]);
        }, timeout);
    }), $(".remove_fields.existing.destroyed").each(function() {
        var $this = $(this), wrapper_class = $this.data("wrapper-class") || "nested-fields";
        $this.closest("." + wrapper_class).hide();
    });
}(jQuery), function(factory) {
    "function" == typeof define && define.amd ? define(factory) :window.purl = factory();
}(function() {
    function parseUri(url, strictMode) {
        for (var str = decodeURI(url), res = parser[strictMode ? "strict" :"loose"].exec(str), uri = {
            attr:{},
            param:{},
            seg:{}
        }, i = 14; i--; ) uri.attr[key[i]] = res[i] || "";
        return uri.param.query = parseString(uri.attr.query), uri.param.fragment = parseString(uri.attr.fragment), 
        uri.seg.path = uri.attr.path.replace(/^\/+|\/+$/g, "").split("/"), uri.seg.fragment = uri.attr.fragment.replace(/^\/+|\/+$/g, "").split("/"), 
        uri.attr.base = uri.attr.host ? (uri.attr.protocol ? uri.attr.protocol + "://" + uri.attr.host :uri.attr.host) + (uri.attr.port ? ":" + uri.attr.port :"") :"", 
        uri;
    }
    function getAttrName(elm) {
        var tn = elm.tagName;
        return "undefined" != typeof tn ? tag2attr[tn.toLowerCase()] :tn;
    }
    function promote(parent, key) {
        if (0 === parent[key].length) return parent[key] = {};
        var t = {};
        for (var i in parent[key]) t[i] = parent[key][i];
        return parent[key] = t, t;
    }
    function parse(parts, parent, key, val) {
        var part = parts.shift();
        if (part) {
            var obj = parent[key] = parent[key] || [];
            "]" == part ? isArray(obj) ? "" !== val && obj.push(val) :"object" == typeof obj ? obj[keys(obj).length] = val :obj = parent[key] = [ parent[key], val ] :~part.indexOf("]") ? (part = part.substr(0, part.length - 1), 
            !isint.test(part) && isArray(obj) && (obj = promote(parent, key)), parse(parts, obj, part, val)) :(!isint.test(part) && isArray(obj) && (obj = promote(parent, key)), 
            parse(parts, obj, part, val));
        } else isArray(parent[key]) ? parent[key].push(val) :parent[key] = "object" == typeof parent[key] ? val :"undefined" == typeof parent[key] ? val :[ parent[key], val ];
    }
    function merge(parent, key, val) {
        if (~key.indexOf("]")) {
            var parts = key.split("[");
            parse(parts, parent, "base", val);
        } else {
            if (!isint.test(key) && isArray(parent.base)) {
                var t = {};
                for (var k in parent.base) t[k] = parent.base[k];
                parent.base = t;
            }
            "" !== key && set(parent.base, key, val);
        }
        return parent;
    }
    function parseString(str) {
        return reduce(String(str).split(/&|;/), function(ret, pair) {
            try {
                pair = decodeURIComponent(pair.replace(/\+/g, " "));
            } catch (e) {}
            var eql = pair.indexOf("="), brace = lastBraceInKey(pair), key = pair.substr(0, brace || eql), val = pair.substr(brace || eql, pair.length);
            return val = val.substr(val.indexOf("=") + 1, val.length), "" === key && (key = pair, 
            val = ""), merge(ret, key, val);
        }, {
            base:{}
        }).base;
    }
    function set(obj, key, val) {
        var v = obj[key];
        "undefined" == typeof v ? obj[key] = val :isArray(v) ? v.push(val) :obj[key] = [ v, val ];
    }
    function lastBraceInKey(str) {
        for (var brace, c, len = str.length, i = 0; len > i; ++i) if (c = str[i], "]" == c && (brace = !1), 
        "[" == c && (brace = !0), "=" == c && !brace) return i;
    }
    function reduce(obj, accumulator) {
        for (var i = 0, l = obj.length >> 0, curr = arguments[2]; l > i; ) i in obj && (curr = accumulator.call(void 0, curr, obj[i], i, obj)), 
        ++i;
        return curr;
    }
    function isArray(vArg) {
        return "[object Array]" === Object.prototype.toString.call(vArg);
    }
    function keys(obj) {
        var key_array = [];
        for (var prop in obj) obj.hasOwnProperty(prop) && key_array.push(prop);
        return key_array;
    }
    function purl(url, strictMode) {
        return 1 === arguments.length && url === !0 && (strictMode = !0, url = void 0), 
        strictMode = strictMode || !1, url = url || window.location.toString(), {
            data:parseUri(url, strictMode),
            attr:function(attr) {
                return attr = aliases[attr] || attr, "undefined" != typeof attr ? this.data.attr[attr] :this.data.attr;
            },
            param:function(param) {
                return "undefined" != typeof param ? this.data.param.query[param] :this.data.param.query;
            },
            fparam:function(param) {
                return "undefined" != typeof param ? this.data.param.fragment[param] :this.data.param.fragment;
            },
            segment:function(seg) {
                return "undefined" == typeof seg ? this.data.seg.path :(seg = 0 > seg ? this.data.seg.path.length + seg :seg - 1, 
                this.data.seg.path[seg]);
            },
            fsegment:function(seg) {
                return "undefined" == typeof seg ? this.data.seg.fragment :(seg = 0 > seg ? this.data.seg.fragment.length + seg :seg - 1, 
                this.data.seg.fragment[seg]);
            }
        };
    }
    var tag2attr = {
        a:"href",
        img:"src",
        form:"action",
        base:"href",
        script:"src",
        iframe:"src",
        link:"href",
        embed:"src",
        object:"data"
    }, key = [ "source", "protocol", "authority", "userInfo", "user", "password", "host", "port", "relative", "path", "directory", "file", "query", "fragment" ], aliases = {
        anchor:"fragment"
    }, parser = {
        strict:/^(?:([^:\/?#]+):)?(?:\/\/((?:(([^:@]*):?([^:@]*))?@)?([^:\/?#]*)(?::(\d*))?))?((((?:[^?#\/]*\/)*)([^?#]*))(?:\?([^#]*))?(?:#(.*))?)/,
        loose:/^(?:(?![^:@]+:[^:@\/]*@)([^:\/?#.]+):)?(?:\/\/)?((?:(([^:@]*):?([^:@]*))?@)?([^:\/?#]*)(?::(\d*))?)(((\/(?:[^?#](?![^?#\/]*\.[^?#\/.]+(?:[?#]|$)))*\/?)?([^?#\/]*))(?:\?([^#]*))?(?:#(.*))?)/
    }, isint = /^[0-9]+$/;
    return purl.jQuery = function($) {
        null != $ && ($.fn.url = function(strictMode) {
            var url = "";
            return this.length && (url = $(this).attr(getAttrName(this[0])) || ""), purl(url, strictMode);
        }, $.url = purl);
    }, purl.jQuery(window.jQuery), purl;
}), Function.prototype.bind && /^object$|^function$/.test(typeof console) && "object" == typeof console.log && "function" == typeof window.addEventListener && [ "log", "info", "warn", "error", "assert", "dir", "clear", "profile", "profileEnd" ].forEach(function(method) {
    console[method] = this.call(console[method], console);
}, Function.prototype.bind), window.log || (window.log = function() {
    var i, sliced, args = arguments, isIECompatibilityView = !1, isIE8 = function() {
        return (!Function.prototype.bind || Function.prototype.bind && "undefined" == typeof window.addEventListener) && "object" == typeof console && "object" == typeof console.log;
    };
    if (log.history = log.history || [], log.history.push(arguments), log.detailPrint && log.needsDetailPrint && function() {
        var ua = navigator.userAgent, winRegexp = /Windows\sNT\s(\d+\.\d+)/;
        console && console.log && /MSIE\s(\d+)/.test(ua) && winRegexp.test(ua) && parseFloat(winRegexp.exec(ua)[1]) >= 6.1 && (isIECompatibilityView = !0);
    }(), isIECompatibilityView || "function" == typeof console.log) if (sliced = Array.prototype.slice.call(args), 
    log.detailPrint && log.needsDetailPrint) for (console.log("-----------------"), 
    args = log.detailPrint(args), i = 0; i < args.length; ) console.log(args[i]), i++; else console.log(1 === sliced.length && "string" == typeof sliced[0] ? sliced.toString() :sliced); else if (isIE8()) if (log.detailPrint) for (args = log.detailPrint(args), 
    args.unshift("-----------------"), i = 0; i < args.length; ) Function.prototype.call.call(console.log, console, Array.prototype.slice.call([ args[i] ])), 
    i++; else Function.prototype.call.call(console.log, console, Array.prototype.slice.call(args)); else document.getElementById("firebug-lite") ? setTimeout(function() {
        window.log.apply(window, args);
    }, 500) :(!function() {
        var script = document.createElement("script");
        script.type = "text/javascript", script.id = "firebug-lite", script.src = "https://getfirebug.com/firebug-lite.js", 
        document.getElementsByTagName("HEAD")[0].appendChild(script);
    }(), setTimeout(function() {
        window.log.apply(window, args);
    }, 2e3));
}), window.log = window.log || function() {}, window.log.needsDetailPrint = function() {
    var uaCheck, uaVersion, ua = window.navigator.userAgent;
    if (/iPad|iPhone|iPod/.test(window.navigator.platform)) {
        if (uaCheck = ua.match(/OS\s([0-9]{1})_([0-9]{1})/), uaVersion = uaCheck ? parseInt(uaCheck[1], 10) :0, 
        uaVersion >= 6) return !0;
    } else if (window.opera) {
        if (uaCheck = /Version\/(\d+)\.\d+/, uaCheck.test(ua) && parseInt(uaCheck.exec(ua)[1], 10) <= 11) return !0;
    } else if (/MSIE\s\d/.test(ua)) return !0;
    return !1;
}(), window.log.detailPrint = function(args) {
    for (var j, thisArg, argType, str, beginStr, getSpecificType = function(obj) {
        for (var reportedType = Object.prototype.toString.call(obj), types = "Array,Date,RegExp,Null".split(","), found = "", n = types.length; n--; ) if (reportedType === "[object " + types[n] + "]") {
            found = types[n].toLowerCase();
            break;
        }
        return found.length ? found :("object" == typeof HTMLElement && obj instanceof HTMLElement || "string" == typeof obj.nodeName && 1 === obj.nodeType ? found = "element" :("object" == typeof Node && obj instanceof Node || "number" == typeof obj.nodeType && "string" == typeof obj.nodeName) && (found = "node"), 
        /^\[object (HTMLCollection|NodeList|Object)\]$/.test(reportedType) && "number" == typeof obj.length && "undefined" != typeof obj.item && (0 === obj.length || "object" == typeof obj[0] && obj[0].nodeType > 0) && (found = "node"), 
        found.length ? found :typeof obj);
    }, detailedArgs = [], i = 0; i < args.length; ) {
        if (thisArg = args[i], argType = typeof thisArg, beginStr = "Item " + (i + 1) + "/" + args.length + " ", 
        "object" === argType) {
            if (argType = getSpecificType(thisArg), "array" === argType) if (thisArg.length) {
                for (j = thisArg.length > 3 ? 3 :thisArg.length, str = ""; j--; ) str = getSpecificType(thisArg[j]) + ", " + str;
                thisArg.length > 3 ? str += "..." :str = str.replace(/,\s$/, ""), detailedArgs.push(beginStr + "(array, length=" + thisArg.length + ", [" + str + "]) ", thisArg);
            } else detailedArgs.push(beginStr + "(array, empty) ", thisArg); else if ("element" === argType) str = thisArg.nodeName.toLowerCase(), 
            thisArg.id && (str += "#" + thisArg.id), thisArg.className && (str += "." + thisArg.className.replace(/\s+/g, ".")), 
            detailedArgs.push(beginStr + "(element, " + str + ") ", thisArg); else if ("date" === argType) detailedArgs.push(beginStr + "(date) ", thisArg.toUTCString()); else if (detailedArgs.push(beginStr + "(" + argType + ")", thisArg), 
            "object" === argType && "function" == typeof thisArg.hasOwnProperty) for (j in thisArg) thisArg.hasOwnProperty(j) && detailedArgs.push('  --> "' + j + '" = (' + getSpecificType(thisArg[j]) + ") ", thisArg[j]);
        } else detailedArgs.push(beginStr + "(" + typeof thisArg + ") ", thisArg);
        i++;
    }
    return detailedArgs;
}, function() {
    var root = this, previousUnderscore = root._, breaker = {}, ArrayProto = Array.prototype, ObjProto = Object.prototype, FuncProto = Function.prototype, push = ArrayProto.push, slice = ArrayProto.slice, concat = ArrayProto.concat, toString = ObjProto.toString, hasOwnProperty = ObjProto.hasOwnProperty, nativeForEach = ArrayProto.forEach, nativeMap = ArrayProto.map, nativeReduce = ArrayProto.reduce, nativeReduceRight = ArrayProto.reduceRight, nativeFilter = ArrayProto.filter, nativeEvery = ArrayProto.every, nativeSome = ArrayProto.some, nativeIndexOf = ArrayProto.indexOf, nativeLastIndexOf = ArrayProto.lastIndexOf, nativeIsArray = Array.isArray, nativeKeys = Object.keys, nativeBind = FuncProto.bind, _ = function(obj) {
        return obj instanceof _ ? obj :this instanceof _ ? void (this._wrapped = obj) :new _(obj);
    };
    "undefined" != typeof exports ? ("undefined" != typeof module && module.exports && (exports = module.exports = _), 
    exports._ = _) :root._ = _, _.VERSION = "1.5.2";
    var each = _.each = _.forEach = function(obj, iterator, context) {
        if (null == obj) return obj;
        if (nativeForEach && obj.forEach === nativeForEach) obj.forEach(iterator, context); else if (obj.length === +obj.length) {
            for (var i = 0, length = obj.length; length > i; i++) if (iterator.call(context, obj[i], i, obj) === breaker) return;
        } else for (var keys = _.keys(obj), i = 0, length = keys.length; length > i; i++) if (iterator.call(context, obj[keys[i]], keys[i], obj) === breaker) return;
        return obj;
    };
    _.map = _.collect = function(obj, iterator, context) {
        var results = [];
        return null == obj ? results :nativeMap && obj.map === nativeMap ? obj.map(iterator, context) :(each(obj, function(value, index, list) {
            results.push(iterator.call(context, value, index, list));
        }), results);
    };
    var reduceError = "Reduce of empty array with no initial value";
    _.reduce = _.foldl = _.inject = function(obj, iterator, memo, context) {
        var initial = arguments.length > 2;
        if (null == obj && (obj = []), nativeReduce && obj.reduce === nativeReduce) return context && (iterator = _.bind(iterator, context)), 
        initial ? obj.reduce(iterator, memo) :obj.reduce(iterator);
        if (each(obj, function(value, index, list) {
            initial ? memo = iterator.call(context, memo, value, index, list) :(memo = value, 
            initial = !0);
        }), !initial) throw new TypeError(reduceError);
        return memo;
    }, _.reduceRight = _.foldr = function(obj, iterator, memo, context) {
        var initial = arguments.length > 2;
        if (null == obj && (obj = []), nativeReduceRight && obj.reduceRight === nativeReduceRight) return context && (iterator = _.bind(iterator, context)), 
        initial ? obj.reduceRight(iterator, memo) :obj.reduceRight(iterator);
        var length = obj.length;
        if (length !== +length) {
            var keys = _.keys(obj);
            length = keys.length;
        }
        if (each(obj, function(value, index, list) {
            index = keys ? keys[--length] :--length, initial ? memo = iterator.call(context, memo, obj[index], index, list) :(memo = obj[index], 
            initial = !0);
        }), !initial) throw new TypeError(reduceError);
        return memo;
    }, _.find = _.detect = function(obj, iterator, context) {
        var result;
        return any(obj, function(value, index, list) {
            return iterator.call(context, value, index, list) ? (result = value, !0) :void 0;
        }), result;
    }, _.filter = _.select = function(obj, iterator, context) {
        var results = [];
        return null == obj ? results :nativeFilter && obj.filter === nativeFilter ? obj.filter(iterator, context) :(each(obj, function(value, index, list) {
            iterator.call(context, value, index, list) && results.push(value);
        }), results);
    }, _.reject = function(obj, iterator, context) {
        return _.filter(obj, function(value, index, list) {
            return !iterator.call(context, value, index, list);
        }, context);
    }, _.every = _.all = function(obj, iterator, context) {
        iterator || (iterator = _.identity);
        var result = !0;
        return null == obj ? result :nativeEvery && obj.every === nativeEvery ? obj.every(iterator, context) :(each(obj, function(value, index, list) {
            return (result = result && iterator.call(context, value, index, list)) ? void 0 :breaker;
        }), !!result);
    };
    var any = _.some = _.any = function(obj, iterator, context) {
        iterator || (iterator = _.identity);
        var result = !1;
        return null == obj ? result :nativeSome && obj.some === nativeSome ? obj.some(iterator, context) :(each(obj, function(value, index, list) {
            return result || (result = iterator.call(context, value, index, list)) ? breaker :void 0;
        }), !!result);
    };
    _.contains = _.include = function(obj, target) {
        return null == obj ? !1 :nativeIndexOf && obj.indexOf === nativeIndexOf ? -1 != obj.indexOf(target) :any(obj, function(value) {
            return value === target;
        });
    }, _.invoke = function(obj, method) {
        var args = slice.call(arguments, 2), isFunc = _.isFunction(method);
        return _.map(obj, function(value) {
            return (isFunc ? method :value[method]).apply(value, args);
        });
    }, _.pluck = function(obj, key) {
        return _.map(obj, _.property(key));
    }, _.where = function(obj, attrs, first) {
        return _[first ? "find" :"filter"](obj, function(value) {
            for (var key in attrs) if (attrs[key] !== value[key]) return !1;
            return !0;
        });
    }, _.findWhere = function(obj, attrs) {
        return _.where(obj, attrs, !0);
    }, _.max = function(obj, iterator, context) {
        if (!iterator && _.isArray(obj) && obj[0] === +obj[0] && obj.length < 65535) return Math.max.apply(Math, obj);
        if (!iterator && _.isEmpty(obj)) return -1/0;
        var result = {
            computed:-1/0,
            value:-1/0
        };
        return each(obj, function(value, index, list) {
            var computed = iterator ? iterator.call(context, value, index, list) :value;
            computed > result.computed && (result = {
                value:value,
                computed:computed
            });
        }), result.value;
    }, _.min = function(obj, iterator, context) {
        if (!iterator && _.isArray(obj) && obj[0] === +obj[0] && obj.length < 65535) return Math.min.apply(Math, obj);
        if (!iterator && _.isEmpty(obj)) return 1/0;
        var result = {
            computed:1/0,
            value:1/0
        };
        return each(obj, function(value, index, list) {
            var computed = iterator ? iterator.call(context, value, index, list) :value;
            computed < result.computed && (result = {
                value:value,
                computed:computed
            });
        }), result.value;
    }, _.shuffle = function(obj) {
        var rand, index = 0, shuffled = [];
        return each(obj, function(value) {
            rand = _.random(index++), shuffled[index - 1] = shuffled[rand], shuffled[rand] = value;
        }), shuffled;
    }, _.sample = function(obj, n, guard) {
        return null == n || guard ? (obj.length !== +obj.length && (obj = _.values(obj)), 
        obj[_.random(obj.length - 1)]) :_.shuffle(obj).slice(0, Math.max(0, n));
    };
    var lookupIterator = function(value) {
        return null == value ? _.identity :_.isFunction(value) ? value :_.property(value);
    };
    _.sortBy = function(obj, iterator, context) {
        return iterator = lookupIterator(iterator), _.pluck(_.map(obj, function(value, index, list) {
            return {
                value:value,
                index:index,
                criteria:iterator.call(context, value, index, list)
            };
        }).sort(function(left, right) {
            var a = left.criteria, b = right.criteria;
            if (a !== b) {
                if (a > b || void 0 === a) return 1;
                if (b > a || void 0 === b) return -1;
            }
            return left.index - right.index;
        }), "value");
    };
    var group = function(behavior) {
        return function(obj, iterator, context) {
            var result = {};
            return iterator = lookupIterator(iterator), each(obj, function(value, index) {
                var key = iterator.call(context, value, index, obj);
                behavior(result, key, value);
            }), result;
        };
    };
    _.groupBy = group(function(result, key, value) {
        _.has(result, key) ? result[key].push(value) :result[key] = [ value ];
    }), _.indexBy = group(function(result, key, value) {
        result[key] = value;
    }), _.countBy = group(function(result, key) {
        _.has(result, key) ? result[key]++ :result[key] = 1;
    }), _.sortedIndex = function(array, obj, iterator, context) {
        iterator = lookupIterator(iterator);
        for (var value = iterator.call(context, obj), low = 0, high = array.length; high > low; ) {
            var mid = low + high >>> 1;
            iterator.call(context, array[mid]) < value ? low = mid + 1 :high = mid;
        }
        return low;
    }, _.toArray = function(obj) {
        return obj ? _.isArray(obj) ? slice.call(obj) :obj.length === +obj.length ? _.map(obj, _.identity) :_.values(obj) :[];
    }, _.size = function(obj) {
        return null == obj ? 0 :obj.length === +obj.length ? obj.length :_.keys(obj).length;
    }, _.first = _.head = _.take = function(array, n, guard) {
        return null == array ? void 0 :null == n || guard ? array[0] :0 > n ? [] :slice.call(array, 0, n);
    }, _.initial = function(array, n, guard) {
        return slice.call(array, 0, array.length - (null == n || guard ? 1 :n));
    }, _.last = function(array, n, guard) {
        return null == array ? void 0 :null == n || guard ? array[array.length - 1] :slice.call(array, Math.max(array.length - n, 0));
    }, _.rest = _.tail = _.drop = function(array, n, guard) {
        return slice.call(array, null == n || guard ? 1 :n);
    }, _.compact = function(array) {
        return _.filter(array, _.identity);
    };
    var flatten = function(input, shallow, output) {
        return shallow && _.every(input, _.isArray) ? concat.apply(output, input) :(each(input, function(value) {
            _.isArray(value) || _.isArguments(value) ? shallow ? push.apply(output, value) :flatten(value, shallow, output) :output.push(value);
        }), output);
    };
    _.flatten = function(array, shallow) {
        return flatten(array, shallow, []);
    }, _.without = function(array) {
        return _.difference(array, slice.call(arguments, 1));
    }, _.partition = function(array, predicate) {
        var pass = [], fail = [];
        return each(array, function(elem) {
            (predicate(elem) ? pass :fail).push(elem);
        }), [ pass, fail ];
    }, _.uniq = _.unique = function(array, isSorted, iterator, context) {
        _.isFunction(isSorted) && (context = iterator, iterator = isSorted, isSorted = !1);
        var initial = iterator ? _.map(array, iterator, context) :array, results = [], seen = [];
        return each(initial, function(value, index) {
            (isSorted ? index && seen[seen.length - 1] === value :_.contains(seen, value)) || (seen.push(value), 
            results.push(array[index]));
        }), results;
    }, _.union = function() {
        return _.uniq(_.flatten(arguments, !0));
    }, _.intersection = function(array) {
        var rest = slice.call(arguments, 1);
        return _.filter(_.uniq(array), function(item) {
            return _.every(rest, function(other) {
                return _.contains(other, item);
            });
        });
    }, _.difference = function(array) {
        var rest = concat.apply(ArrayProto, slice.call(arguments, 1));
        return _.filter(array, function(value) {
            return !_.contains(rest, value);
        });
    }, _.zip = function() {
        for (var length = _.max(_.pluck(arguments, "length").concat(0)), results = new Array(length), i = 0; length > i; i++) results[i] = _.pluck(arguments, "" + i);
        return results;
    }, _.object = function(list, values) {
        if (null == list) return {};
        for (var result = {}, i = 0, length = list.length; length > i; i++) values ? result[list[i]] = values[i] :result[list[i][0]] = list[i][1];
        return result;
    }, _.indexOf = function(array, item, isSorted) {
        if (null == array) return -1;
        var i = 0, length = array.length;
        if (isSorted) {
            if ("number" != typeof isSorted) return i = _.sortedIndex(array, item), array[i] === item ? i :-1;
            i = 0 > isSorted ? Math.max(0, length + isSorted) :isSorted;
        }
        if (nativeIndexOf && array.indexOf === nativeIndexOf) return array.indexOf(item, isSorted);
        for (;length > i; i++) if (array[i] === item) return i;
        return -1;
    }, _.lastIndexOf = function(array, item, from) {
        if (null == array) return -1;
        var hasIndex = null != from;
        if (nativeLastIndexOf && array.lastIndexOf === nativeLastIndexOf) return hasIndex ? array.lastIndexOf(item, from) :array.lastIndexOf(item);
        for (var i = hasIndex ? from :array.length; i--; ) if (array[i] === item) return i;
        return -1;
    }, _.range = function(start, stop, step) {
        arguments.length <= 1 && (stop = start || 0, start = 0), step = arguments[2] || 1;
        for (var length = Math.max(Math.ceil((stop - start) / step), 0), idx = 0, range = new Array(length); length > idx; ) range[idx++] = start, 
        start += step;
        return range;
    };
    var ctor = function() {};
    _.bind = function(func, context) {
        var args, bound;
        if (nativeBind && func.bind === nativeBind) return nativeBind.apply(func, slice.call(arguments, 1));
        if (!_.isFunction(func)) throw new TypeError();
        return args = slice.call(arguments, 2), bound = function() {
            if (!(this instanceof bound)) return func.apply(context, args.concat(slice.call(arguments)));
            ctor.prototype = func.prototype;
            var self = new ctor();
            ctor.prototype = null;
            var result = func.apply(self, args.concat(slice.call(arguments)));
            return Object(result) === result ? result :self;
        };
    }, _.partial = function(func) {
        var boundArgs = slice.call(arguments, 1);
        return function() {
            for (var position = 0, args = boundArgs.slice(), i = 0, length = args.length; length > i; i++) args[i] === _ && (args[i] = arguments[position++]);
            for (;position < arguments.length; ) args.push(arguments[position++]);
            return func.apply(this, args);
        };
    }, _.bindAll = function(obj) {
        var funcs = slice.call(arguments, 1);
        if (0 === funcs.length) throw new Error("bindAll must be passed function names");
        return each(funcs, function(f) {
            obj[f] = _.bind(obj[f], obj);
        }), obj;
    }, _.memoize = function(func, hasher) {
        var memo = {};
        return hasher || (hasher = _.identity), function() {
            var key = hasher.apply(this, arguments);
            return _.has(memo, key) ? memo[key] :memo[key] = func.apply(this, arguments);
        };
    }, _.delay = function(func, wait) {
        var args = slice.call(arguments, 2);
        return setTimeout(function() {
            return func.apply(null, args);
        }, wait);
    }, _.defer = function(func) {
        return _.delay.apply(_, [ func, 1 ].concat(slice.call(arguments, 1)));
    }, _.throttle = function(func, wait, options) {
        var context, args, result, timeout = null, previous = 0;
        options || (options = {});
        var later = function() {
            previous = options.leading === !1 ? 0 :_.now(), timeout = null, result = func.apply(context, args), 
            context = args = null;
        };
        return function() {
            var now = _.now();
            previous || options.leading !== !1 || (previous = now);
            var remaining = wait - (now - previous);
            return context = this, args = arguments, 0 >= remaining ? (clearTimeout(timeout), 
            timeout = null, previous = now, result = func.apply(context, args), context = args = null) :timeout || options.trailing === !1 || (timeout = setTimeout(later, remaining)), 
            result;
        };
    }, _.debounce = function(func, wait, immediate) {
        var timeout, args, context, timestamp, result, later = function() {
            var last = _.now() - timestamp;
            wait > last ? timeout = setTimeout(later, wait - last) :(timeout = null, immediate || (result = func.apply(context, args), 
            context = args = null));
        };
        return function() {
            context = this, args = arguments, timestamp = _.now();
            var callNow = immediate && !timeout;
            return timeout || (timeout = setTimeout(later, wait)), callNow && (result = func.apply(context, args), 
            context = args = null), result;
        };
    }, _.once = function(func) {
        var memo, ran = !1;
        return function() {
            return ran ? memo :(ran = !0, memo = func.apply(this, arguments), func = null, memo);
        };
    }, _.wrap = function(func, wrapper) {
        return _.partial(wrapper, func);
    }, _.compose = function() {
        var funcs = arguments;
        return function() {
            for (var args = arguments, i = funcs.length - 1; i >= 0; i--) args = [ funcs[i].apply(this, args) ];
            return args[0];
        };
    }, _.after = function(times, func) {
        return function() {
            return --times < 1 ? func.apply(this, arguments) :void 0;
        };
    }, _.keys = function(obj) {
        if (!_.isObject(obj)) return [];
        if (nativeKeys) return nativeKeys(obj);
        var keys = [];
        for (var key in obj) _.has(obj, key) && keys.push(key);
        return keys;
    }, _.values = function(obj) {
        for (var keys = _.keys(obj), length = keys.length, values = new Array(length), i = 0; length > i; i++) values[i] = obj[keys[i]];
        return values;
    }, _.pairs = function(obj) {
        for (var keys = _.keys(obj), length = keys.length, pairs = new Array(length), i = 0; length > i; i++) pairs[i] = [ keys[i], obj[keys[i]] ];
        return pairs;
    }, _.invert = function(obj) {
        for (var result = {}, keys = _.keys(obj), i = 0, length = keys.length; length > i; i++) result[obj[keys[i]]] = keys[i];
        return result;
    }, _.functions = _.methods = function(obj) {
        var names = [];
        for (var key in obj) _.isFunction(obj[key]) && names.push(key);
        return names.sort();
    }, _.extend = function(obj) {
        return each(slice.call(arguments, 1), function(source) {
            if (source) for (var prop in source) obj[prop] = source[prop];
        }), obj;
    }, _.pick = function(obj) {
        var copy = {}, keys = concat.apply(ArrayProto, slice.call(arguments, 1));
        return each(keys, function(key) {
            key in obj && (copy[key] = obj[key]);
        }), copy;
    }, _.omit = function(obj) {
        var copy = {}, keys = concat.apply(ArrayProto, slice.call(arguments, 1));
        for (var key in obj) _.contains(keys, key) || (copy[key] = obj[key]);
        return copy;
    }, _.defaults = function(obj) {
        return each(slice.call(arguments, 1), function(source) {
            if (source) for (var prop in source) void 0 === obj[prop] && (obj[prop] = source[prop]);
        }), obj;
    }, _.clone = function(obj) {
        return _.isObject(obj) ? _.isArray(obj) ? obj.slice() :_.extend({}, obj) :obj;
    }, _.tap = function(obj, interceptor) {
        return interceptor(obj), obj;
    };
    var eq = function(a, b, aStack, bStack) {
        if (a === b) return 0 !== a || 1 / a == 1 / b;
        if (null == a || null == b) return a === b;
        a instanceof _ && (a = a._wrapped), b instanceof _ && (b = b._wrapped);
        var className = toString.call(a);
        if (className != toString.call(b)) return !1;
        switch (className) {
          case "[object String]":
            return a == String(b);

          case "[object Number]":
            return a != +a ? b != +b :0 == a ? 1 / a == 1 / b :a == +b;

          case "[object Date]":
          case "[object Boolean]":
            return +a == +b;

          case "[object RegExp]":
            return a.source == b.source && a.global == b.global && a.multiline == b.multiline && a.ignoreCase == b.ignoreCase;
        }
        if ("object" != typeof a || "object" != typeof b) return !1;
        for (var length = aStack.length; length--; ) if (aStack[length] == a) return bStack[length] == b;
        var aCtor = a.constructor, bCtor = b.constructor;
        if (aCtor !== bCtor && !(_.isFunction(aCtor) && aCtor instanceof aCtor && _.isFunction(bCtor) && bCtor instanceof bCtor) && "constructor" in a && "constructor" in b) return !1;
        aStack.push(a), bStack.push(b);
        var size = 0, result = !0;
        if ("[object Array]" == className) {
            if (size = a.length, result = size == b.length) for (;size-- && (result = eq(a[size], b[size], aStack, bStack)); ) ;
        } else {
            for (var key in a) if (_.has(a, key) && (size++, !(result = _.has(b, key) && eq(a[key], b[key], aStack, bStack)))) break;
            if (result) {
                for (key in b) if (_.has(b, key) && !size--) break;
                result = !size;
            }
        }
        return aStack.pop(), bStack.pop(), result;
    };
    _.isEqual = function(a, b) {
        return eq(a, b, [], []);
    }, _.isEmpty = function(obj) {
        if (null == obj) return !0;
        if (_.isArray(obj) || _.isString(obj)) return 0 === obj.length;
        for (var key in obj) if (_.has(obj, key)) return !1;
        return !0;
    }, _.isElement = function(obj) {
        return !(!obj || 1 !== obj.nodeType);
    }, _.isArray = nativeIsArray || function(obj) {
        return "[object Array]" == toString.call(obj);
    }, _.isObject = function(obj) {
        return obj === Object(obj);
    }, each([ "Arguments", "Function", "String", "Number", "Date", "RegExp" ], function(name) {
        _["is" + name] = function(obj) {
            return toString.call(obj) == "[object " + name + "]";
        };
    }), _.isArguments(arguments) || (_.isArguments = function(obj) {
        return !(!obj || !_.has(obj, "callee"));
    }), "function" != typeof /./ && (_.isFunction = function(obj) {
        return "function" == typeof obj;
    }), _.isFinite = function(obj) {
        return isFinite(obj) && !isNaN(parseFloat(obj));
    }, _.isNaN = function(obj) {
        return _.isNumber(obj) && obj != +obj;
    }, _.isBoolean = function(obj) {
        return obj === !0 || obj === !1 || "[object Boolean]" == toString.call(obj);
    }, _.isNull = function(obj) {
        return null === obj;
    }, _.isUndefined = function(obj) {
        return void 0 === obj;
    }, _.has = function(obj, key) {
        return hasOwnProperty.call(obj, key);
    }, _.noConflict = function() {
        return root._ = previousUnderscore, this;
    }, _.identity = function(value) {
        return value;
    }, _.constant = function(value) {
        return function() {
            return value;
        };
    }, _.property = function(key) {
        return function(obj) {
            return obj[key];
        };
    }, _.times = function(n, iterator, context) {
        for (var accum = Array(Math.max(0, n)), i = 0; n > i; i++) accum[i] = iterator.call(context, i);
        return accum;
    }, _.random = function(min, max) {
        return null == max && (max = min, min = 0), min + Math.floor(Math.random() * (max - min + 1));
    }, _.now = Date.now || function() {
        return new Date().getTime();
    };
    var entityMap = {
        escape:{
            "&":"&amp;",
            "<":"&lt;",
            ">":"&gt;",
            '"':"&quot;",
            "'":"&#x27;"
        }
    };
    entityMap.unescape = _.invert(entityMap.escape);
    var entityRegexes = {
        escape:new RegExp("[" + _.keys(entityMap.escape).join("") + "]", "g"),
        unescape:new RegExp("(" + _.keys(entityMap.unescape).join("|") + ")", "g")
    };
    _.each([ "escape", "unescape" ], function(method) {
        _[method] = function(string) {
            return null == string ? "" :("" + string).replace(entityRegexes[method], function(match) {
                return entityMap[method][match];
            });
        };
    }), _.result = function(object, property) {
        if (null == object) return void 0;
        var value = object[property];
        return _.isFunction(value) ? value.call(object) :value;
    }, _.mixin = function(obj) {
        each(_.functions(obj), function(name) {
            var func = _[name] = obj[name];
            _.prototype[name] = function() {
                var args = [ this._wrapped ];
                return push.apply(args, arguments), result.call(this, func.apply(_, args));
            };
        });
    };
    var idCounter = 0;
    _.uniqueId = function(prefix) {
        var id = ++idCounter + "";
        return prefix ? prefix + id :id;
    }, _.templateSettings = {
        evaluate:/<%([\s\S]+?)%>/g,
        interpolate:/<%=([\s\S]+?)%>/g,
        escape:/<%-([\s\S]+?)%>/g
    };
    var noMatch = /(.)^/, escapes = {
        "'":"'",
        "\\":"\\",
        "\r":"r",
        "\n":"n",
        "	":"t",
        "\u2028":"u2028",
        "\u2029":"u2029"
    }, escaper = /\\|'|\r|\n|\t|\u2028|\u2029/g;
    _.template = function(text, data, settings) {
        var render;
        settings = _.defaults({}, settings, _.templateSettings);
        var matcher = new RegExp([ (settings.escape || noMatch).source, (settings.interpolate || noMatch).source, (settings.evaluate || noMatch).source ].join("|") + "|$", "g"), index = 0, source = "__p+='";
        text.replace(matcher, function(match, escape, interpolate, evaluate, offset) {
            return source += text.slice(index, offset).replace(escaper, function(match) {
                return "\\" + escapes[match];
            }), escape && (source += "'+\n((__t=(" + escape + "))==null?'':_.escape(__t))+\n'"), 
            interpolate && (source += "'+\n((__t=(" + interpolate + "))==null?'':__t)+\n'"), 
            evaluate && (source += "';\n" + evaluate + "\n__p+='"), index = offset + match.length, 
            match;
        }), source += "';\n", settings.variable || (source = "with(obj||{}){\n" + source + "}\n"), 
        source = "var __t,__p='',__j=Array.prototype.join,print=function(){__p+=__j.call(arguments,'');};\n" + source + "return __p;\n";
        try {
            render = new Function(settings.variable || "obj", "_", source);
        } catch (e) {
            throw e.source = source, e;
        }
        if (data) return render(data, _);
        var template = function(data) {
            return render.call(this, data, _);
        };
        return template.source = "function(" + (settings.variable || "obj") + "){\n" + source + "}", 
        template;
    }, _.chain = function(obj) {
        return _(obj).chain();
    };
    var result = function(obj) {
        return this._chain ? _(obj).chain() :obj;
    };
    _.mixin(_), each([ "pop", "push", "reverse", "shift", "sort", "splice", "unshift" ], function(name) {
        var method = ArrayProto[name];
        _.prototype[name] = function() {
            var obj = this._wrapped;
            return method.apply(obj, arguments), "shift" != name && "splice" != name || 0 !== obj.length || delete obj[0], 
            result.call(this, obj);
        };
    }), each([ "concat", "join", "slice" ], function(name) {
        var method = ArrayProto[name];
        _.prototype[name] = function() {
            return result.call(this, method.apply(this._wrapped, arguments));
        };
    }), _.extend(_.prototype, {
        chain:function() {
            return this._chain = !0, this;
        },
        value:function() {
            return this._wrapped;
        }
    }), "function" == typeof define && define.amd && define("underscore", [], function() {
        return _;
    });
}.call(this), function(undefined) {
    function defaultParsingFlags() {
        return {
            empty:!1,
            unusedTokens:[],
            unusedInput:[],
            overflow:-2,
            charsLeftOver:0,
            nullInput:!1,
            invalidMonth:null,
            invalidFormat:!1,
            userInvalidated:!1,
            iso:!1
        };
    }
    function padToken(func, count) {
        return function(a) {
            return leftZeroFill(func.call(this, a), count);
        };
    }
    function ordinalizeToken(func, period) {
        return function(a) {
            return this.lang().ordinal(func.call(this, a), period);
        };
    }
    function Language() {}
    function Moment(config) {
        checkOverflow(config), extend(this, config);
    }
    function Duration(duration) {
        var normalizedInput = normalizeObjectUnits(duration), years = normalizedInput.year || 0, months = normalizedInput.month || 0, weeks = normalizedInput.week || 0, days = normalizedInput.day || 0, hours = normalizedInput.hour || 0, minutes = normalizedInput.minute || 0, seconds = normalizedInput.second || 0, milliseconds = normalizedInput.millisecond || 0;
        this._milliseconds = +milliseconds + 1e3 * seconds + 6e4 * minutes + 36e5 * hours, 
        this._days = +days + 7 * weeks, this._months = +months + 12 * years, this._data = {}, 
        this._bubble();
    }
    function extend(a, b) {
        for (var i in b) b.hasOwnProperty(i) && (a[i] = b[i]);
        return b.hasOwnProperty("toString") && (a.toString = b.toString), b.hasOwnProperty("valueOf") && (a.valueOf = b.valueOf), 
        a;
    }
    function cloneMoment(m) {
        var i, result = {};
        for (i in m) m.hasOwnProperty(i) && momentProperties.hasOwnProperty(i) && (result[i] = m[i]);
        return result;
    }
    function absRound(number) {
        return 0 > number ? Math.ceil(number) :Math.floor(number);
    }
    function leftZeroFill(number, targetLength, forceSign) {
        for (var output = "" + Math.abs(number), sign = number >= 0; output.length < targetLength; ) output = "0" + output;
        return (sign ? forceSign ? "+" :"" :"-") + output;
    }
    function addOrSubtractDurationFromMoment(mom, duration, isAdding, ignoreUpdateOffset) {
        var minutes, hours, milliseconds = duration._milliseconds, days = duration._days, months = duration._months;
        milliseconds && mom._d.setTime(+mom._d + milliseconds * isAdding), (days || months) && (minutes = mom.minute(), 
        hours = mom.hour()), days && mom.date(mom.date() + days * isAdding), months && mom.month(mom.month() + months * isAdding), 
        milliseconds && !ignoreUpdateOffset && moment.updateOffset(mom), (days || months) && (mom.minute(minutes), 
        mom.hour(hours));
    }
    function isArray(input) {
        return "[object Array]" === Object.prototype.toString.call(input);
    }
    function isDate(input) {
        return "[object Date]" === Object.prototype.toString.call(input) || input instanceof Date;
    }
    function compareArrays(array1, array2, dontConvert) {
        var i, len = Math.min(array1.length, array2.length), lengthDiff = Math.abs(array1.length - array2.length), diffs = 0;
        for (i = 0; len > i; i++) (dontConvert && array1[i] !== array2[i] || !dontConvert && toInt(array1[i]) !== toInt(array2[i])) && diffs++;
        return diffs + lengthDiff;
    }
    function normalizeUnits(units) {
        if (units) {
            var lowered = units.toLowerCase().replace(/(.)s$/, "$1");
            units = unitAliases[units] || camelFunctions[lowered] || lowered;
        }
        return units;
    }
    function normalizeObjectUnits(inputObject) {
        var normalizedProp, prop, normalizedInput = {};
        for (prop in inputObject) inputObject.hasOwnProperty(prop) && (normalizedProp = normalizeUnits(prop), 
        normalizedProp && (normalizedInput[normalizedProp] = inputObject[prop]));
        return normalizedInput;
    }
    function makeList(field) {
        var count, setter;
        if (0 === field.indexOf("week")) count = 7, setter = "day"; else {
            if (0 !== field.indexOf("month")) return;
            count = 12, setter = "month";
        }
        moment[field] = function(format, index) {
            var i, getter, method = moment.fn._lang[field], results = [];
            if ("number" == typeof format && (index = format, format = undefined), getter = function(i) {
                var m = moment().utc().set(setter, i);
                return method.call(moment.fn._lang, m, format || "");
            }, null != index) return getter(index);
            for (i = 0; count > i; i++) results.push(getter(i));
            return results;
        };
    }
    function toInt(argumentForCoercion) {
        var coercedNumber = +argumentForCoercion, value = 0;
        return 0 !== coercedNumber && isFinite(coercedNumber) && (value = coercedNumber >= 0 ? Math.floor(coercedNumber) :Math.ceil(coercedNumber)), 
        value;
    }
    function daysInMonth(year, month) {
        return new Date(Date.UTC(year, month + 1, 0)).getUTCDate();
    }
    function daysInYear(year) {
        return isLeapYear(year) ? 366 :365;
    }
    function isLeapYear(year) {
        return year % 4 === 0 && year % 100 !== 0 || year % 400 === 0;
    }
    function checkOverflow(m) {
        var overflow;
        m._a && -2 === m._pf.overflow && (overflow = m._a[MONTH] < 0 || m._a[MONTH] > 11 ? MONTH :m._a[DATE] < 1 || m._a[DATE] > daysInMonth(m._a[YEAR], m._a[MONTH]) ? DATE :m._a[HOUR] < 0 || m._a[HOUR] > 23 ? HOUR :m._a[MINUTE] < 0 || m._a[MINUTE] > 59 ? MINUTE :m._a[SECOND] < 0 || m._a[SECOND] > 59 ? SECOND :m._a[MILLISECOND] < 0 || m._a[MILLISECOND] > 999 ? MILLISECOND :-1, 
        m._pf._overflowDayOfYear && (YEAR > overflow || overflow > DATE) && (overflow = DATE), 
        m._pf.overflow = overflow);
    }
    function isValid(m) {
        return null == m._isValid && (m._isValid = !isNaN(m._d.getTime()) && m._pf.overflow < 0 && !m._pf.empty && !m._pf.invalidMonth && !m._pf.nullInput && !m._pf.invalidFormat && !m._pf.userInvalidated, 
        m._strict && (m._isValid = m._isValid && 0 === m._pf.charsLeftOver && 0 === m._pf.unusedTokens.length)), 
        m._isValid;
    }
    function normalizeLanguage(key) {
        return key ? key.toLowerCase().replace("_", "-") :key;
    }
    function makeAs(input, model) {
        return model._isUTC ? moment(input).zone(model._offset || 0) :moment(input).local();
    }
    function loadLang(key, values) {
        return values.abbr = key, languages[key] || (languages[key] = new Language()), languages[key].set(values), 
        languages[key];
    }
    function unloadLang(key) {
        delete languages[key];
    }
    function getLangDefinition(key) {
        var j, lang, next, split, i = 0, get = function(k) {
            if (!languages[k] && hasModule) try {
                require("./lang/" + k);
            } catch (e) {}
            return languages[k];
        };
        if (!key) return moment.fn._lang;
        if (!isArray(key)) {
            if (lang = get(key)) return lang;
            key = [ key ];
        }
        for (;i < key.length; ) {
            for (split = normalizeLanguage(key[i]).split("-"), j = split.length, next = normalizeLanguage(key[i + 1]), 
            next = next ? next.split("-") :null; j > 0; ) {
                if (lang = get(split.slice(0, j).join("-"))) return lang;
                if (next && next.length >= j && compareArrays(split, next, !0) >= j - 1) break;
                j--;
            }
            i++;
        }
        return moment.fn._lang;
    }
    function removeFormattingTokens(input) {
        return input.match(/\[[\s\S]/) ? input.replace(/^\[|\]$/g, "") :input.replace(/\\/g, "");
    }
    function makeFormatFunction(format) {
        var i, length, array = format.match(formattingTokens);
        for (i = 0, length = array.length; length > i; i++) array[i] = formatTokenFunctions[array[i]] ? formatTokenFunctions[array[i]] :removeFormattingTokens(array[i]);
        return function(mom) {
            var output = "";
            for (i = 0; length > i; i++) output += array[i] instanceof Function ? array[i].call(mom, format) :array[i];
            return output;
        };
    }
    function formatMoment(m, format) {
        return m.isValid() ? (format = expandFormat(format, m.lang()), formatFunctions[format] || (formatFunctions[format] = makeFormatFunction(format)), 
        formatFunctions[format](m)) :m.lang().invalidDate();
    }
    function expandFormat(format, lang) {
        function replaceLongDateFormatTokens(input) {
            return lang.longDateFormat(input) || input;
        }
        var i = 5;
        for (localFormattingTokens.lastIndex = 0; i >= 0 && localFormattingTokens.test(format); ) format = format.replace(localFormattingTokens, replaceLongDateFormatTokens), 
        localFormattingTokens.lastIndex = 0, i -= 1;
        return format;
    }
    function getParseRegexForToken(token, config) {
        var a, strict = config._strict;
        switch (token) {
          case "DDDD":
            return parseTokenThreeDigits;

          case "YYYY":
          case "GGGG":
          case "gggg":
            return strict ? parseTokenFourDigits :parseTokenOneToFourDigits;

          case "Y":
          case "G":
          case "g":
            return parseTokenSignedNumber;

          case "YYYYYY":
          case "YYYYY":
          case "GGGGG":
          case "ggggg":
            return strict ? parseTokenSixDigits :parseTokenOneToSixDigits;

          case "S":
            if (strict) return parseTokenOneDigit;

          case "SS":
            if (strict) return parseTokenTwoDigits;

          case "SSS":
            if (strict) return parseTokenThreeDigits;

          case "DDD":
            return parseTokenOneToThreeDigits;

          case "MMM":
          case "MMMM":
          case "dd":
          case "ddd":
          case "dddd":
            return parseTokenWord;

          case "a":
          case "A":
            return getLangDefinition(config._l)._meridiemParse;

          case "X":
            return parseTokenTimestampMs;

          case "Z":
          case "ZZ":
            return parseTokenTimezone;

          case "T":
            return parseTokenT;

          case "SSSS":
            return parseTokenDigits;

          case "MM":
          case "DD":
          case "YY":
          case "GG":
          case "gg":
          case "HH":
          case "hh":
          case "mm":
          case "ss":
          case "ww":
          case "WW":
            return strict ? parseTokenTwoDigits :parseTokenOneOrTwoDigits;

          case "M":
          case "D":
          case "d":
          case "H":
          case "h":
          case "m":
          case "s":
          case "w":
          case "W":
          case "e":
          case "E":
            return parseTokenOneOrTwoDigits;

          default:
            return a = new RegExp(regexpEscape(unescapeFormat(token.replace("\\", "")), "i"));
        }
    }
    function timezoneMinutesFromString(string) {
        string = string || "";
        var possibleTzMatches = string.match(parseTokenTimezone) || [], tzChunk = possibleTzMatches[possibleTzMatches.length - 1] || [], parts = (tzChunk + "").match(parseTimezoneChunker) || [ "-", 0, 0 ], minutes = +(60 * parts[1]) + toInt(parts[2]);
        return "+" === parts[0] ? -minutes :minutes;
    }
    function addTimeToArrayFromToken(token, input, config) {
        var a, datePartArray = config._a;
        switch (token) {
          case "M":
          case "MM":
            null != input && (datePartArray[MONTH] = toInt(input) - 1);
            break;

          case "MMM":
          case "MMMM":
            a = getLangDefinition(config._l).monthsParse(input), null != a ? datePartArray[MONTH] = a :config._pf.invalidMonth = input;
            break;

          case "D":
          case "DD":
            null != input && (datePartArray[DATE] = toInt(input));
            break;

          case "DDD":
          case "DDDD":
            null != input && (config._dayOfYear = toInt(input));
            break;

          case "YY":
            datePartArray[YEAR] = toInt(input) + (toInt(input) > 68 ? 1900 :2e3);
            break;

          case "YYYY":
          case "YYYYY":
          case "YYYYYY":
            datePartArray[YEAR] = toInt(input);
            break;

          case "a":
          case "A":
            config._isPm = getLangDefinition(config._l).isPM(input);
            break;

          case "H":
          case "HH":
          case "h":
          case "hh":
            datePartArray[HOUR] = toInt(input);
            break;

          case "m":
          case "mm":
            datePartArray[MINUTE] = toInt(input);
            break;

          case "s":
          case "ss":
            datePartArray[SECOND] = toInt(input);
            break;

          case "S":
          case "SS":
          case "SSS":
          case "SSSS":
            datePartArray[MILLISECOND] = toInt(1e3 * ("0." + input));
            break;

          case "X":
            config._d = new Date(1e3 * parseFloat(input));
            break;

          case "Z":
          case "ZZ":
            config._useUTC = !0, config._tzm = timezoneMinutesFromString(input);
            break;

          case "w":
          case "ww":
          case "W":
          case "WW":
          case "d":
          case "dd":
          case "ddd":
          case "dddd":
          case "e":
          case "E":
            token = token.substr(0, 1);

          case "gg":
          case "gggg":
          case "GG":
          case "GGGG":
          case "GGGGG":
            token = token.substr(0, 2), input && (config._w = config._w || {}, config._w[token] = input);
        }
    }
    function dateFromConfig(config) {
        var i, date, currentDate, yearToUse, fixYear, w, temp, lang, weekday, week, input = [];
        if (!config._d) {
            for (currentDate = currentDateArray(config), config._w && null == config._a[DATE] && null == config._a[MONTH] && (fixYear = function(val) {
                var int_val = parseInt(val, 10);
                return val ? val.length < 3 ? int_val > 68 ? 1900 + int_val :2e3 + int_val :int_val :null == config._a[YEAR] ? moment().weekYear() :config._a[YEAR];
            }, w = config._w, null != w.GG || null != w.W || null != w.E ? temp = dayOfYearFromWeeks(fixYear(w.GG), w.W || 1, w.E, 4, 1) :(lang = getLangDefinition(config._l), 
            weekday = null != w.d ? parseWeekday(w.d, lang) :null != w.e ? parseInt(w.e, 10) + lang._week.dow :0, 
            week = parseInt(w.w, 10) || 1, null != w.d && weekday < lang._week.dow && week++, 
            temp = dayOfYearFromWeeks(fixYear(w.gg), week, weekday, lang._week.doy, lang._week.dow)), 
            config._a[YEAR] = temp.year, config._dayOfYear = temp.dayOfYear), config._dayOfYear && (yearToUse = null == config._a[YEAR] ? currentDate[YEAR] :config._a[YEAR], 
            config._dayOfYear > daysInYear(yearToUse) && (config._pf._overflowDayOfYear = !0), 
            date = makeUTCDate(yearToUse, 0, config._dayOfYear), config._a[MONTH] = date.getUTCMonth(), 
            config._a[DATE] = date.getUTCDate()), i = 0; 3 > i && null == config._a[i]; ++i) config._a[i] = input[i] = currentDate[i];
            for (;7 > i; i++) config._a[i] = input[i] = null == config._a[i] ? 2 === i ? 1 :0 :config._a[i];
            input[HOUR] += toInt((config._tzm || 0) / 60), input[MINUTE] += toInt((config._tzm || 0) % 60), 
            config._d = (config._useUTC ? makeUTCDate :makeDate).apply(null, input);
        }
    }
    function dateFromObject(config) {
        var normalizedInput;
        config._d || (normalizedInput = normalizeObjectUnits(config._i), config._a = [ normalizedInput.year, normalizedInput.month, normalizedInput.day, normalizedInput.hour, normalizedInput.minute, normalizedInput.second, normalizedInput.millisecond ], 
        dateFromConfig(config));
    }
    function currentDateArray(config) {
        var now = new Date();
        return config._useUTC ? [ now.getUTCFullYear(), now.getUTCMonth(), now.getUTCDate() ] :[ now.getFullYear(), now.getMonth(), now.getDate() ];
    }
    function makeDateFromStringAndFormat(config) {
        config._a = [], config._pf.empty = !0;
        var i, parsedInput, tokens, token, skipped, lang = getLangDefinition(config._l), string = "" + config._i, stringLength = string.length, totalParsedInputLength = 0;
        for (tokens = expandFormat(config._f, lang).match(formattingTokens) || [], i = 0; i < tokens.length; i++) token = tokens[i], 
        parsedInput = (string.match(getParseRegexForToken(token, config)) || [])[0], parsedInput && (skipped = string.substr(0, string.indexOf(parsedInput)), 
        skipped.length > 0 && config._pf.unusedInput.push(skipped), string = string.slice(string.indexOf(parsedInput) + parsedInput.length), 
        totalParsedInputLength += parsedInput.length), formatTokenFunctions[token] ? (parsedInput ? config._pf.empty = !1 :config._pf.unusedTokens.push(token), 
        addTimeToArrayFromToken(token, parsedInput, config)) :config._strict && !parsedInput && config._pf.unusedTokens.push(token);
        config._pf.charsLeftOver = stringLength - totalParsedInputLength, string.length > 0 && config._pf.unusedInput.push(string), 
        config._isPm && config._a[HOUR] < 12 && (config._a[HOUR] += 12), config._isPm === !1 && 12 === config._a[HOUR] && (config._a[HOUR] = 0), 
        dateFromConfig(config), checkOverflow(config);
    }
    function unescapeFormat(s) {
        return s.replace(/\\(\[)|\\(\])|\[([^\]\[]*)\]|\\(.)/g, function(matched, p1, p2, p3, p4) {
            return p1 || p2 || p3 || p4;
        });
    }
    function regexpEscape(s) {
        return s.replace(/[-\/\\^$*+?.()|[\]{}]/g, "\\$&");
    }
    function makeDateFromStringAndArray(config) {
        var tempConfig, bestMoment, scoreToBeat, i, currentScore;
        if (0 === config._f.length) return config._pf.invalidFormat = !0, void (config._d = new Date(0/0));
        for (i = 0; i < config._f.length; i++) currentScore = 0, tempConfig = extend({}, config), 
        tempConfig._pf = defaultParsingFlags(), tempConfig._f = config._f[i], makeDateFromStringAndFormat(tempConfig), 
        isValid(tempConfig) && (currentScore += tempConfig._pf.charsLeftOver, currentScore += 10 * tempConfig._pf.unusedTokens.length, 
        tempConfig._pf.score = currentScore, (null == scoreToBeat || scoreToBeat > currentScore) && (scoreToBeat = currentScore, 
        bestMoment = tempConfig));
        extend(config, bestMoment || tempConfig);
    }
    function makeDateFromString(config) {
        var i, l, string = config._i, match = isoRegex.exec(string);
        if (match) {
            for (config._pf.iso = !0, i = 0, l = isoDates.length; l > i; i++) if (isoDates[i][1].exec(string)) {
                config._f = isoDates[i][0] + (match[6] || " ");
                break;
            }
            for (i = 0, l = isoTimes.length; l > i; i++) if (isoTimes[i][1].exec(string)) {
                config._f += isoTimes[i][0];
                break;
            }
            string.match(parseTokenTimezone) && (config._f += "Z"), makeDateFromStringAndFormat(config);
        } else config._d = new Date(string);
    }
    function makeDateFromInput(config) {
        var input = config._i, matched = aspNetJsonRegex.exec(input);
        input === undefined ? config._d = new Date() :matched ? config._d = new Date(+matched[1]) :"string" == typeof input ? makeDateFromString(config) :isArray(input) ? (config._a = input.slice(0), 
        dateFromConfig(config)) :isDate(input) ? config._d = new Date(+input) :"object" == typeof input ? dateFromObject(config) :config._d = new Date(input);
    }
    function makeDate(y, m, d, h, M, s, ms) {
        var date = new Date(y, m, d, h, M, s, ms);
        return 1970 > y && date.setFullYear(y), date;
    }
    function makeUTCDate(y) {
        var date = new Date(Date.UTC.apply(null, arguments));
        return 1970 > y && date.setUTCFullYear(y), date;
    }
    function parseWeekday(input, language) {
        if ("string" == typeof input) if (isNaN(input)) {
            if (input = language.weekdaysParse(input), "number" != typeof input) return null;
        } else input = parseInt(input, 10);
        return input;
    }
    function substituteTimeAgo(string, number, withoutSuffix, isFuture, lang) {
        return lang.relativeTime(number || 1, !!withoutSuffix, string, isFuture);
    }
    function relativeTime(milliseconds, withoutSuffix, lang) {
        var seconds = round(Math.abs(milliseconds) / 1e3), minutes = round(seconds / 60), hours = round(minutes / 60), days = round(hours / 24), years = round(days / 365), args = 45 > seconds && [ "s", seconds ] || 1 === minutes && [ "m" ] || 45 > minutes && [ "mm", minutes ] || 1 === hours && [ "h" ] || 22 > hours && [ "hh", hours ] || 1 === days && [ "d" ] || 25 >= days && [ "dd", days ] || 45 >= days && [ "M" ] || 345 > days && [ "MM", round(days / 30) ] || 1 === years && [ "y" ] || [ "yy", years ];
        return args[2] = withoutSuffix, args[3] = milliseconds > 0, args[4] = lang, substituteTimeAgo.apply({}, args);
    }
    function weekOfYear(mom, firstDayOfWeek, firstDayOfWeekOfYear) {
        var adjustedMoment, end = firstDayOfWeekOfYear - firstDayOfWeek, daysToDayOfWeek = firstDayOfWeekOfYear - mom.day();
        return daysToDayOfWeek > end && (daysToDayOfWeek -= 7), end - 7 > daysToDayOfWeek && (daysToDayOfWeek += 7), 
        adjustedMoment = moment(mom).add("d", daysToDayOfWeek), {
            week:Math.ceil(adjustedMoment.dayOfYear() / 7),
            year:adjustedMoment.year()
        };
    }
    function dayOfYearFromWeeks(year, week, weekday, firstDayOfWeekOfYear, firstDayOfWeek) {
        var daysToAdd, dayOfYear, d = makeUTCDate(year, 0, 1).getUTCDay();
        return weekday = null != weekday ? weekday :firstDayOfWeek, daysToAdd = firstDayOfWeek - d + (d > firstDayOfWeekOfYear ? 7 :0) - (firstDayOfWeek > d ? 7 :0), 
        dayOfYear = 7 * (week - 1) + (weekday - firstDayOfWeek) + daysToAdd + 1, {
            year:dayOfYear > 0 ? year :year - 1,
            dayOfYear:dayOfYear > 0 ? dayOfYear :daysInYear(year - 1) + dayOfYear
        };
    }
    function makeMoment(config) {
        var input = config._i, format = config._f;
        return null === input ? moment.invalid({
            nullInput:!0
        }) :("string" == typeof input && (config._i = input = getLangDefinition().preparse(input)), 
        moment.isMoment(input) ? (config = cloneMoment(input), config._d = new Date(+input._d)) :format ? isArray(format) ? makeDateFromStringAndArray(config) :makeDateFromStringAndFormat(config) :makeDateFromInput(config), 
        new Moment(config));
    }
    function makeGetterAndSetter(name, key) {
        moment.fn[name] = moment.fn[name + "s"] = function(input) {
            var utc = this._isUTC ? "UTC" :"";
            return null != input ? (this._d["set" + utc + key](input), moment.updateOffset(this), 
            this) :this._d["get" + utc + key]();
        };
    }
    function makeDurationGetter(name) {
        moment.duration.fn[name] = function() {
            return this._data[name];
        };
    }
    function makeDurationAsGetter(name, factor) {
        moment.duration.fn["as" + name] = function() {
            return +this / factor;
        };
    }
    function makeGlobal(deprecate) {
        var warned = !1, local_moment = moment;
        "undefined" == typeof ender && (deprecate ? (global.moment = function() {
            return !warned && console && console.warn && (warned = !0, console.warn("Accessing Moment through the global scope is deprecated, and will be removed in an upcoming release.")), 
            local_moment.apply(null, arguments);
        }, extend(global.moment, local_moment)) :global.moment = moment);
    }
    for (var moment, i, VERSION = "2.5.1", global = this, round = Math.round, YEAR = 0, MONTH = 1, DATE = 2, HOUR = 3, MINUTE = 4, SECOND = 5, MILLISECOND = 6, languages = {}, momentProperties = {
        _isAMomentObject:null,
        _i:null,
        _f:null,
        _l:null,
        _strict:null,
        _isUTC:null,
        _offset:null,
        _pf:null,
        _lang:null
    }, hasModule = "undefined" != typeof module && module.exports && "undefined" != typeof require, aspNetJsonRegex = /^\/?Date\((\-?\d+)/i, aspNetTimeSpanJsonRegex = /(\-)?(?:(\d*)\.)?(\d+)\:(\d+)(?:\:(\d+)\.?(\d{3})?)?/, isoDurationRegex = /^(-)?P(?:(?:([0-9,.]*)Y)?(?:([0-9,.]*)M)?(?:([0-9,.]*)D)?(?:T(?:([0-9,.]*)H)?(?:([0-9,.]*)M)?(?:([0-9,.]*)S)?)?|([0-9,.]*)W)$/, formattingTokens = /(\[[^\[]*\])|(\\)?(Mo|MM?M?M?|Do|DDDo|DD?D?D?|ddd?d?|do?|w[o|w]?|W[o|W]?|YYYYYY|YYYYY|YYYY|YY|gg(ggg?)?|GG(GGG?)?|e|E|a|A|hh?|HH?|mm?|ss?|S{1,4}|X|zz?|ZZ?|.)/g, localFormattingTokens = /(\[[^\[]*\])|(\\)?(LT|LL?L?L?|l{1,4})/g, parseTokenOneOrTwoDigits = /\d\d?/, parseTokenOneToThreeDigits = /\d{1,3}/, parseTokenOneToFourDigits = /\d{1,4}/, parseTokenOneToSixDigits = /[+\-]?\d{1,6}/, parseTokenDigits = /\d+/, parseTokenWord = /[0-9]*['a-z\u00A0-\u05FF\u0700-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+|[\u0600-\u06FF\/]+(\s*?[\u0600-\u06FF]+){1,2}/i, parseTokenTimezone = /Z|[\+\-]\d\d:?\d\d/gi, parseTokenT = /T/i, parseTokenTimestampMs = /[\+\-]?\d+(\.\d{1,3})?/, parseTokenOneDigit = /\d/, parseTokenTwoDigits = /\d\d/, parseTokenThreeDigits = /\d{3}/, parseTokenFourDigits = /\d{4}/, parseTokenSixDigits = /[+-]?\d{6}/, parseTokenSignedNumber = /[+-]?\d+/, isoRegex = /^\s*(?:[+-]\d{6}|\d{4})-(?:(\d\d-\d\d)|(W\d\d$)|(W\d\d-\d)|(\d\d\d))((T| )(\d\d(:\d\d(:\d\d(\.\d+)?)?)?)?([\+\-]\d\d(?::?\d\d)?|\s*Z)?)?$/, isoFormat = "YYYY-MM-DDTHH:mm:ssZ", isoDates = [ [ "YYYYYY-MM-DD", /[+-]\d{6}-\d{2}-\d{2}/ ], [ "YYYY-MM-DD", /\d{4}-\d{2}-\d{2}/ ], [ "GGGG-[W]WW-E", /\d{4}-W\d{2}-\d/ ], [ "GGGG-[W]WW", /\d{4}-W\d{2}/ ], [ "YYYY-DDD", /\d{4}-\d{3}/ ] ], isoTimes = [ [ "HH:mm:ss.SSSS", /(T| )\d\d:\d\d:\d\d\.\d{1,3}/ ], [ "HH:mm:ss", /(T| )\d\d:\d\d:\d\d/ ], [ "HH:mm", /(T| )\d\d:\d\d/ ], [ "HH", /(T| )\d\d/ ] ], parseTimezoneChunker = /([\+\-]|\d\d)/gi, proxyGettersAndSetters = "Date|Hours|Minutes|Seconds|Milliseconds".split("|"), unitMillisecondFactors = {
        Milliseconds:1,
        Seconds:1e3,
        Minutes:6e4,
        Hours:36e5,
        Days:864e5,
        Months:2592e6,
        Years:31536e6
    }, unitAliases = {
        ms:"millisecond",
        s:"second",
        m:"minute",
        h:"hour",
        d:"day",
        D:"date",
        w:"week",
        W:"isoWeek",
        M:"month",
        y:"year",
        DDD:"dayOfYear",
        e:"weekday",
        E:"isoWeekday",
        gg:"weekYear",
        GG:"isoWeekYear"
    }, camelFunctions = {
        dayofyear:"dayOfYear",
        isoweekday:"isoWeekday",
        isoweek:"isoWeek",
        weekyear:"weekYear",
        isoweekyear:"isoWeekYear"
    }, formatFunctions = {}, ordinalizeTokens = "DDD w W M D d".split(" "), paddedTokens = "M D H h m s w W".split(" "), formatTokenFunctions = {
        M:function() {
            return this.month() + 1;
        },
        MMM:function(format) {
            return this.lang().monthsShort(this, format);
        },
        MMMM:function(format) {
            return this.lang().months(this, format);
        },
        D:function() {
            return this.date();
        },
        DDD:function() {
            return this.dayOfYear();
        },
        d:function() {
            return this.day();
        },
        dd:function(format) {
            return this.lang().weekdaysMin(this, format);
        },
        ddd:function(format) {
            return this.lang().weekdaysShort(this, format);
        },
        dddd:function(format) {
            return this.lang().weekdays(this, format);
        },
        w:function() {
            return this.week();
        },
        W:function() {
            return this.isoWeek();
        },
        YY:function() {
            return leftZeroFill(this.year() % 100, 2);
        },
        YYYY:function() {
            return leftZeroFill(this.year(), 4);
        },
        YYYYY:function() {
            return leftZeroFill(this.year(), 5);
        },
        YYYYYY:function() {
            var y = this.year(), sign = y >= 0 ? "+" :"-";
            return sign + leftZeroFill(Math.abs(y), 6);
        },
        gg:function() {
            return leftZeroFill(this.weekYear() % 100, 2);
        },
        gggg:function() {
            return leftZeroFill(this.weekYear(), 4);
        },
        ggggg:function() {
            return leftZeroFill(this.weekYear(), 5);
        },
        GG:function() {
            return leftZeroFill(this.isoWeekYear() % 100, 2);
        },
        GGGG:function() {
            return leftZeroFill(this.isoWeekYear(), 4);
        },
        GGGGG:function() {
            return leftZeroFill(this.isoWeekYear(), 5);
        },
        e:function() {
            return this.weekday();
        },
        E:function() {
            return this.isoWeekday();
        },
        a:function() {
            return this.lang().meridiem(this.hours(), this.minutes(), !0);
        },
        A:function() {
            return this.lang().meridiem(this.hours(), this.minutes(), !1);
        },
        H:function() {
            return this.hours();
        },
        h:function() {
            return this.hours() % 12 || 12;
        },
        m:function() {
            return this.minutes();
        },
        s:function() {
            return this.seconds();
        },
        S:function() {
            return toInt(this.milliseconds() / 100);
        },
        SS:function() {
            return leftZeroFill(toInt(this.milliseconds() / 10), 2);
        },
        SSS:function() {
            return leftZeroFill(this.milliseconds(), 3);
        },
        SSSS:function() {
            return leftZeroFill(this.milliseconds(), 3);
        },
        Z:function() {
            var a = -this.zone(), b = "+";
            return 0 > a && (a = -a, b = "-"), b + leftZeroFill(toInt(a / 60), 2) + ":" + leftZeroFill(toInt(a) % 60, 2);
        },
        ZZ:function() {
            var a = -this.zone(), b = "+";
            return 0 > a && (a = -a, b = "-"), b + leftZeroFill(toInt(a / 60), 2) + leftZeroFill(toInt(a) % 60, 2);
        },
        z:function() {
            return this.zoneAbbr();
        },
        zz:function() {
            return this.zoneName();
        },
        X:function() {
            return this.unix();
        },
        Q:function() {
            return this.quarter();
        }
    }, lists = [ "months", "monthsShort", "weekdays", "weekdaysShort", "weekdaysMin" ]; ordinalizeTokens.length; ) i = ordinalizeTokens.pop(), 
    formatTokenFunctions[i + "o"] = ordinalizeToken(formatTokenFunctions[i], i);
    for (;paddedTokens.length; ) i = paddedTokens.pop(), formatTokenFunctions[i + i] = padToken(formatTokenFunctions[i], 2);
    for (formatTokenFunctions.DDDD = padToken(formatTokenFunctions.DDD, 3), extend(Language.prototype, {
        set:function(config) {
            var prop, i;
            for (i in config) prop = config[i], "function" == typeof prop ? this[i] = prop :this["_" + i] = prop;
        },
        _months:"January_February_March_April_May_June_July_August_September_October_November_December".split("_"),
        months:function(m) {
            return this._months[m.month()];
        },
        _monthsShort:"Jan_Feb_Mar_Apr_May_Jun_Jul_Aug_Sep_Oct_Nov_Dec".split("_"),
        monthsShort:function(m) {
            return this._monthsShort[m.month()];
        },
        monthsParse:function(monthName) {
            var i, mom, regex;
            for (this._monthsParse || (this._monthsParse = []), i = 0; 12 > i; i++) if (this._monthsParse[i] || (mom = moment.utc([ 2e3, i ]), 
            regex = "^" + this.months(mom, "") + "|^" + this.monthsShort(mom, ""), this._monthsParse[i] = new RegExp(regex.replace(".", ""), "i")), 
            this._monthsParse[i].test(monthName)) return i;
        },
        _weekdays:"Sunday_Monday_Tuesday_Wednesday_Thursday_Friday_Saturday".split("_"),
        weekdays:function(m) {
            return this._weekdays[m.day()];
        },
        _weekdaysShort:"Sun_Mon_Tue_Wed_Thu_Fri_Sat".split("_"),
        weekdaysShort:function(m) {
            return this._weekdaysShort[m.day()];
        },
        _weekdaysMin:"Su_Mo_Tu_We_Th_Fr_Sa".split("_"),
        weekdaysMin:function(m) {
            return this._weekdaysMin[m.day()];
        },
        weekdaysParse:function(weekdayName) {
            var i, mom, regex;
            for (this._weekdaysParse || (this._weekdaysParse = []), i = 0; 7 > i; i++) if (this._weekdaysParse[i] || (mom = moment([ 2e3, 1 ]).day(i), 
            regex = "^" + this.weekdays(mom, "") + "|^" + this.weekdaysShort(mom, "") + "|^" + this.weekdaysMin(mom, ""), 
            this._weekdaysParse[i] = new RegExp(regex.replace(".", ""), "i")), this._weekdaysParse[i].test(weekdayName)) return i;
        },
        _longDateFormat:{
            LT:"h:mm A",
            L:"MM/DD/YYYY",
            LL:"MMMM D YYYY",
            LLL:"MMMM D YYYY LT",
            LLLL:"dddd, MMMM D YYYY LT"
        },
        longDateFormat:function(key) {
            var output = this._longDateFormat[key];
            return !output && this._longDateFormat[key.toUpperCase()] && (output = this._longDateFormat[key.toUpperCase()].replace(/MMMM|MM|DD|dddd/g, function(val) {
                return val.slice(1);
            }), this._longDateFormat[key] = output), output;
        },
        isPM:function(input) {
            return "p" === (input + "").toLowerCase().charAt(0);
        },
        _meridiemParse:/[ap]\.?m?\.?/i,
        meridiem:function(hours, minutes, isLower) {
            return hours > 11 ? isLower ? "pm" :"PM" :isLower ? "am" :"AM";
        },
        _calendar:{
            sameDay:"[Today at] LT",
            nextDay:"[Tomorrow at] LT",
            nextWeek:"dddd [at] LT",
            lastDay:"[Yesterday at] LT",
            lastWeek:"[Last] dddd [at] LT",
            sameElse:"L"
        },
        calendar:function(key, mom) {
            var output = this._calendar[key];
            return "function" == typeof output ? output.apply(mom) :output;
        },
        _relativeTime:{
            future:"in %s",
            past:"%s ago",
            s:"a few seconds",
            m:"a minute",
            mm:"%d minutes",
            h:"an hour",
            hh:"%d hours",
            d:"a day",
            dd:"%d days",
            M:"a month",
            MM:"%d months",
            y:"a year",
            yy:"%d years"
        },
        relativeTime:function(number, withoutSuffix, string, isFuture) {
            var output = this._relativeTime[string];
            return "function" == typeof output ? output(number, withoutSuffix, string, isFuture) :output.replace(/%d/i, number);
        },
        pastFuture:function(diff, output) {
            var format = this._relativeTime[diff > 0 ? "future" :"past"];
            return "function" == typeof format ? format(output) :format.replace(/%s/i, output);
        },
        ordinal:function(number) {
            return this._ordinal.replace("%d", number);
        },
        _ordinal:"%d",
        preparse:function(string) {
            return string;
        },
        postformat:function(string) {
            return string;
        },
        week:function(mom) {
            return weekOfYear(mom, this._week.dow, this._week.doy).week;
        },
        _week:{
            dow:0,
            doy:6
        },
        _invalidDate:"Invalid date",
        invalidDate:function() {
            return this._invalidDate;
        }
    }), moment = function(input, format, lang, strict) {
        var c;
        return "boolean" == typeof lang && (strict = lang, lang = undefined), c = {}, c._isAMomentObject = !0, 
        c._i = input, c._f = format, c._l = lang, c._strict = strict, c._isUTC = !1, c._pf = defaultParsingFlags(), 
        makeMoment(c);
    }, moment.utc = function(input, format, lang, strict) {
        var c;
        return "boolean" == typeof lang && (strict = lang, lang = undefined), c = {}, c._isAMomentObject = !0, 
        c._useUTC = !0, c._isUTC = !0, c._l = lang, c._i = input, c._f = format, c._strict = strict, 
        c._pf = defaultParsingFlags(), makeMoment(c).utc();
    }, moment.unix = function(input) {
        return moment(1e3 * input);
    }, moment.duration = function(input, key) {
        var sign, ret, parseIso, duration = input, match = null;
        return moment.isDuration(input) ? duration = {
            ms:input._milliseconds,
            d:input._days,
            M:input._months
        } :"number" == typeof input ? (duration = {}, key ? duration[key] = input :duration.milliseconds = input) :(match = aspNetTimeSpanJsonRegex.exec(input)) ? (sign = "-" === match[1] ? -1 :1, 
        duration = {
            y:0,
            d:toInt(match[DATE]) * sign,
            h:toInt(match[HOUR]) * sign,
            m:toInt(match[MINUTE]) * sign,
            s:toInt(match[SECOND]) * sign,
            ms:toInt(match[MILLISECOND]) * sign
        }) :(match = isoDurationRegex.exec(input)) && (sign = "-" === match[1] ? -1 :1, 
        parseIso = function(inp) {
            var res = inp && parseFloat(inp.replace(",", "."));
            return (isNaN(res) ? 0 :res) * sign;
        }, duration = {
            y:parseIso(match[2]),
            M:parseIso(match[3]),
            d:parseIso(match[4]),
            h:parseIso(match[5]),
            m:parseIso(match[6]),
            s:parseIso(match[7]),
            w:parseIso(match[8])
        }), ret = new Duration(duration), moment.isDuration(input) && input.hasOwnProperty("_lang") && (ret._lang = input._lang), 
        ret;
    }, moment.version = VERSION, moment.defaultFormat = isoFormat, moment.updateOffset = function() {}, 
    moment.lang = function(key, values) {
        var r;
        return key ? (values ? loadLang(normalizeLanguage(key), values) :null === values ? (unloadLang(key), 
        key = "en") :languages[key] || getLangDefinition(key), r = moment.duration.fn._lang = moment.fn._lang = getLangDefinition(key), 
        r._abbr) :moment.fn._lang._abbr;
    }, moment.langData = function(key) {
        return key && key._lang && key._lang._abbr && (key = key._lang._abbr), getLangDefinition(key);
    }, moment.isMoment = function(obj) {
        return obj instanceof Moment || null != obj && obj.hasOwnProperty("_isAMomentObject");
    }, moment.isDuration = function(obj) {
        return obj instanceof Duration;
    }, i = lists.length - 1; i >= 0; --i) makeList(lists[i]);
    for (moment.normalizeUnits = function(units) {
        return normalizeUnits(units);
    }, moment.invalid = function(flags) {
        var m = moment.utc(0/0);
        return null != flags ? extend(m._pf, flags) :m._pf.userInvalidated = !0, m;
    }, moment.parseZone = function(input) {
        return moment(input).parseZone();
    }, extend(moment.fn = Moment.prototype, {
        clone:function() {
            return moment(this);
        },
        valueOf:function() {
            return +this._d + 6e4 * (this._offset || 0);
        },
        unix:function() {
            return Math.floor(+this / 1e3);
        },
        toString:function() {
            return this.clone().lang("en").format("ddd MMM DD YYYY HH:mm:ss [GMT]ZZ");
        },
        toDate:function() {
            return this._offset ? new Date(+this) :this._d;
        },
        toISOString:function() {
            var m = moment(this).utc();
            return 0 < m.year() && m.year() <= 9999 ? formatMoment(m, "YYYY-MM-DD[T]HH:mm:ss.SSS[Z]") :formatMoment(m, "YYYYYY-MM-DD[T]HH:mm:ss.SSS[Z]");
        },
        toArray:function() {
            var m = this;
            return [ m.year(), m.month(), m.date(), m.hours(), m.minutes(), m.seconds(), m.milliseconds() ];
        },
        isValid:function() {
            return isValid(this);
        },
        isDSTShifted:function() {
            return this._a ? this.isValid() && compareArrays(this._a, (this._isUTC ? moment.utc(this._a) :moment(this._a)).toArray()) > 0 :!1;
        },
        parsingFlags:function() {
            return extend({}, this._pf);
        },
        invalidAt:function() {
            return this._pf.overflow;
        },
        utc:function() {
            return this.zone(0);
        },
        local:function() {
            return this.zone(0), this._isUTC = !1, this;
        },
        format:function(inputString) {
            var output = formatMoment(this, inputString || moment.defaultFormat);
            return this.lang().postformat(output);
        },
        add:function(input, val) {
            var dur;
            return dur = "string" == typeof input ? moment.duration(+val, input) :moment.duration(input, val), 
            addOrSubtractDurationFromMoment(this, dur, 1), this;
        },
        subtract:function(input, val) {
            var dur;
            return dur = "string" == typeof input ? moment.duration(+val, input) :moment.duration(input, val), 
            addOrSubtractDurationFromMoment(this, dur, -1), this;
        },
        diff:function(input, units, asFloat) {
            var diff, output, that = makeAs(input, this), zoneDiff = 6e4 * (this.zone() - that.zone());
            return units = normalizeUnits(units), "year" === units || "month" === units ? (diff = 432e5 * (this.daysInMonth() + that.daysInMonth()), 
            output = 12 * (this.year() - that.year()) + (this.month() - that.month()), output += (this - moment(this).startOf("month") - (that - moment(that).startOf("month"))) / diff, 
            output -= 6e4 * (this.zone() - moment(this).startOf("month").zone() - (that.zone() - moment(that).startOf("month").zone())) / diff, 
            "year" === units && (output /= 12)) :(diff = this - that, output = "second" === units ? diff / 1e3 :"minute" === units ? diff / 6e4 :"hour" === units ? diff / 36e5 :"day" === units ? (diff - zoneDiff) / 864e5 :"week" === units ? (diff - zoneDiff) / 6048e5 :diff), 
            asFloat ? output :absRound(output);
        },
        from:function(time, withoutSuffix) {
            return moment.duration(this.diff(time)).lang(this.lang()._abbr).humanize(!withoutSuffix);
        },
        fromNow:function(withoutSuffix) {
            return this.from(moment(), withoutSuffix);
        },
        calendar:function() {
            var sod = makeAs(moment(), this).startOf("day"), diff = this.diff(sod, "days", !0), format = -6 > diff ? "sameElse" :-1 > diff ? "lastWeek" :0 > diff ? "lastDay" :1 > diff ? "sameDay" :2 > diff ? "nextDay" :7 > diff ? "nextWeek" :"sameElse";
            return this.format(this.lang().calendar(format, this));
        },
        isLeapYear:function() {
            return isLeapYear(this.year());
        },
        isDST:function() {
            return this.zone() < this.clone().month(0).zone() || this.zone() < this.clone().month(5).zone();
        },
        day:function(input) {
            var day = this._isUTC ? this._d.getUTCDay() :this._d.getDay();
            return null != input ? (input = parseWeekday(input, this.lang()), this.add({
                d:input - day
            })) :day;
        },
        month:function(input) {
            var dayOfMonth, utc = this._isUTC ? "UTC" :"";
            return null != input ? "string" == typeof input && (input = this.lang().monthsParse(input), 
            "number" != typeof input) ? this :(dayOfMonth = this.date(), this.date(1), this._d["set" + utc + "Month"](input), 
            this.date(Math.min(dayOfMonth, this.daysInMonth())), moment.updateOffset(this), 
            this) :this._d["get" + utc + "Month"]();
        },
        startOf:function(units) {
            switch (units = normalizeUnits(units)) {
              case "year":
                this.month(0);

              case "month":
                this.date(1);

              case "week":
              case "isoWeek":
              case "day":
                this.hours(0);

              case "hour":
                this.minutes(0);

              case "minute":
                this.seconds(0);

              case "second":
                this.milliseconds(0);
            }
            return "week" === units ? this.weekday(0) :"isoWeek" === units && this.isoWeekday(1), 
            this;
        },
        endOf:function(units) {
            return units = normalizeUnits(units), this.startOf(units).add("isoWeek" === units ? "week" :units, 1).subtract("ms", 1);
        },
        isAfter:function(input, units) {
            return units = "undefined" != typeof units ? units :"millisecond", +this.clone().startOf(units) > +moment(input).startOf(units);
        },
        isBefore:function(input, units) {
            return units = "undefined" != typeof units ? units :"millisecond", +this.clone().startOf(units) < +moment(input).startOf(units);
        },
        isSame:function(input, units) {
            return units = units || "ms", +this.clone().startOf(units) === +makeAs(input, this).startOf(units);
        },
        min:function(other) {
            return other = moment.apply(null, arguments), this > other ? this :other;
        },
        max:function(other) {
            return other = moment.apply(null, arguments), other > this ? this :other;
        },
        zone:function(input) {
            var offset = this._offset || 0;
            return null == input ? this._isUTC ? offset :this._d.getTimezoneOffset() :("string" == typeof input && (input = timezoneMinutesFromString(input)), 
            Math.abs(input) < 16 && (input = 60 * input), this._offset = input, this._isUTC = !0, 
            offset !== input && addOrSubtractDurationFromMoment(this, moment.duration(offset - input, "m"), 1, !0), 
            this);
        },
        zoneAbbr:function() {
            return this._isUTC ? "UTC" :"";
        },
        zoneName:function() {
            return this._isUTC ? "Coordinated Universal Time" :"";
        },
        parseZone:function() {
            return this._tzm ? this.zone(this._tzm) :"string" == typeof this._i && this.zone(this._i), 
            this;
        },
        hasAlignedHourOffset:function(input) {
            return input = input ? moment(input).zone() :0, (this.zone() - input) % 60 === 0;
        },
        daysInMonth:function() {
            return daysInMonth(this.year(), this.month());
        },
        dayOfYear:function(input) {
            var dayOfYear = round((moment(this).startOf("day") - moment(this).startOf("year")) / 864e5) + 1;
            return null == input ? dayOfYear :this.add("d", input - dayOfYear);
        },
        quarter:function() {
            return Math.ceil((this.month() + 1) / 3);
        },
        weekYear:function(input) {
            var year = weekOfYear(this, this.lang()._week.dow, this.lang()._week.doy).year;
            return null == input ? year :this.add("y", input - year);
        },
        isoWeekYear:function(input) {
            var year = weekOfYear(this, 1, 4).year;
            return null == input ? year :this.add("y", input - year);
        },
        week:function(input) {
            var week = this.lang().week(this);
            return null == input ? week :this.add("d", 7 * (input - week));
        },
        isoWeek:function(input) {
            var week = weekOfYear(this, 1, 4).week;
            return null == input ? week :this.add("d", 7 * (input - week));
        },
        weekday:function(input) {
            var weekday = (this.day() + 7 - this.lang()._week.dow) % 7;
            return null == input ? weekday :this.add("d", input - weekday);
        },
        isoWeekday:function(input) {
            return null == input ? this.day() || 7 :this.day(this.day() % 7 ? input :input - 7);
        },
        get:function(units) {
            return units = normalizeUnits(units), this[units]();
        },
        set:function(units, value) {
            return units = normalizeUnits(units), "function" == typeof this[units] && this[units](value), 
            this;
        },
        lang:function(key) {
            return key === undefined ? this._lang :(this._lang = getLangDefinition(key), this);
        }
    }), i = 0; i < proxyGettersAndSetters.length; i++) makeGetterAndSetter(proxyGettersAndSetters[i].toLowerCase().replace(/s$/, ""), proxyGettersAndSetters[i]);
    makeGetterAndSetter("year", "FullYear"), moment.fn.days = moment.fn.day, moment.fn.months = moment.fn.month, 
    moment.fn.weeks = moment.fn.week, moment.fn.isoWeeks = moment.fn.isoWeek, moment.fn.toJSON = moment.fn.toISOString, 
    extend(moment.duration.fn = Duration.prototype, {
        _bubble:function() {
            var seconds, minutes, hours, years, milliseconds = this._milliseconds, days = this._days, months = this._months, data = this._data;
            data.milliseconds = milliseconds % 1e3, seconds = absRound(milliseconds / 1e3), 
            data.seconds = seconds % 60, minutes = absRound(seconds / 60), data.minutes = minutes % 60, 
            hours = absRound(minutes / 60), data.hours = hours % 24, days += absRound(hours / 24), 
            data.days = days % 30, months += absRound(days / 30), data.months = months % 12, 
            years = absRound(months / 12), data.years = years;
        },
        weeks:function() {
            return absRound(this.days() / 7);
        },
        valueOf:function() {
            return this._milliseconds + 864e5 * this._days + this._months % 12 * 2592e6 + 31536e6 * toInt(this._months / 12);
        },
        humanize:function(withSuffix) {
            var difference = +this, output = relativeTime(difference, !withSuffix, this.lang());
            return withSuffix && (output = this.lang().pastFuture(difference, output)), this.lang().postformat(output);
        },
        add:function(input, val) {
            var dur = moment.duration(input, val);
            return this._milliseconds += dur._milliseconds, this._days += dur._days, this._months += dur._months, 
            this._bubble(), this;
        },
        subtract:function(input, val) {
            var dur = moment.duration(input, val);
            return this._milliseconds -= dur._milliseconds, this._days -= dur._days, this._months -= dur._months, 
            this._bubble(), this;
        },
        get:function(units) {
            return units = normalizeUnits(units), this[units.toLowerCase() + "s"]();
        },
        as:function(units) {
            return units = normalizeUnits(units), this["as" + units.charAt(0).toUpperCase() + units.slice(1) + "s"]();
        },
        lang:moment.fn.lang,
        toIsoString:function() {
            var years = Math.abs(this.years()), months = Math.abs(this.months()), days = Math.abs(this.days()), hours = Math.abs(this.hours()), minutes = Math.abs(this.minutes()), seconds = Math.abs(this.seconds() + this.milliseconds() / 1e3);
            return this.asSeconds() ? (this.asSeconds() < 0 ? "-" :"") + "P" + (years ? years + "Y" :"") + (months ? months + "M" :"") + (days ? days + "D" :"") + (hours || minutes || seconds ? "T" :"") + (hours ? hours + "H" :"") + (minutes ? minutes + "M" :"") + (seconds ? seconds + "S" :"") :"P0D";
        }
    });
    for (i in unitMillisecondFactors) unitMillisecondFactors.hasOwnProperty(i) && (makeDurationAsGetter(i, unitMillisecondFactors[i]), 
    makeDurationGetter(i.toLowerCase()));
    makeDurationAsGetter("Weeks", 6048e5), moment.duration.fn.asMonths = function() {
        return (+this - 31536e6 * this.years()) / 2592e6 + 12 * this.years();
    }, moment.lang("en", {
        ordinal:function(number) {
            var b = number % 10, output = 1 === toInt(number % 100 / 10) ? "th" :1 === b ? "st" :2 === b ? "nd" :3 === b ? "rd" :"th";
            return number + output;
        }
    }), hasModule ? (module.exports = moment, makeGlobal(!0)) :"function" == typeof define && define.amd ? define("moment", function(require, exports, module) {
        return module.config && module.config() && module.config().noGlobal !== !0 && makeGlobal(module.config().noGlobal === undefined), 
        moment;
    }) :makeGlobal();
}.call(this), /*
    jQuery Masked Input Plugin
    Copyright (c) 2007 - 2013 Josh Bush (digitalbush.com)
    Licensed under the MIT license (http://digitalbush.com/projects/masked-input-plugin/#license)
    Version: 1.3.1
*/
!function(a) {
    function b() {
        var a = document.createElement("input"), b = "onpaste";
        return a.setAttribute(b, ""), "function" == typeof a[b] ? "paste" :"input";
    }
    var c, d = b() + ".mask", e = navigator.userAgent, f = /iphone/i.test(e), g = /chrome/i.test(e), h = /android/i.test(e);
    a.mask = {
        definitions:{
            9:"[0-9]",
            a:"[A-Za-z]",
            "*":"[A-Za-z0-9]"
        },
        autoclear:!0,
        dataName:"rawMaskFn",
        placeholder:"_"
    }, a.fn.extend({
        caret:function(a, b) {
            var c;
            return 0 === this.length || this.is(":hidden") ? void 0 :"number" == typeof a ? (b = "number" == typeof b ? b :a, 
            this.each(function() {
                this.setSelectionRange ? this.setSelectionRange(a, b) :this.createTextRange && (c = this.createTextRange(), 
                c.collapse(!0), c.moveEnd("character", b), c.moveStart("character", a), c.select());
            })) :(this[0].setSelectionRange ? (a = this[0].selectionStart, b = this[0].selectionEnd) :document.selection && document.selection.createRange && (c = document.selection.createRange(), 
            a = 0 - c.duplicate().moveStart("character", -1e5), b = a + c.text.length), {
                begin:a,
                end:b
            });
        },
        unmask:function() {
            return this.trigger("unmask");
        },
        mask:function(b, e) {
            var i, j, k, l, m, n;
            return !b && this.length > 0 ? (i = a(this[0]), i.data(a.mask.dataName)()) :(e = a.extend({
                autoclear:a.mask.autoclear,
                placeholder:a.mask.placeholder,
                completed:null
            }, e), j = a.mask.definitions, k = [], l = n = b.length, m = null, a.each(b.split(""), function(a, b) {
                "?" == b ? (n--, l = a) :j[b] ? (k.push(new RegExp(j[b])), null === m && (m = k.length - 1)) :k.push(null);
            }), this.trigger("unmask").each(function() {
                function i(a) {
                    for (;++a < n && !k[a]; ) ;
                    return a;
                }
                function o(a) {
                    for (;--a >= 0 && !k[a]; ) ;
                    return a;
                }
                function p(a, b) {
                    var c, d;
                    if (!(0 > a)) {
                        for (c = a, d = i(b); n > c; c++) if (k[c]) {
                            if (!(n > d && k[c].test(x[d]))) break;
                            x[c] = x[d], x[d] = e.placeholder, d = i(d);
                        }
                        u(), w.caret(Math.max(m, a));
                    }
                }
                function q(a) {
                    var b, c, d, f;
                    for (b = a, c = e.placeholder; n > b; b++) if (k[b]) {
                        if (d = i(b), f = x[b], x[b] = c, !(n > d && k[d].test(f))) break;
                        c = f;
                    }
                }
                function r(a) {
                    var b, c, d, e = a.which;
                    8 === e || 46 === e || f && 127 === e ? (b = w.caret(), c = b.begin, d = b.end, 
                    0 === d - c && (c = 46 !== e ? o(c) :d = i(c - 1), d = 46 === e ? i(d) :d), t(c, d), 
                    p(c, d - 1), a.preventDefault()) :27 == e && (w.val(z), w.caret(0, v()), a.preventDefault());
                }
                function s(b) {
                    var c, d, f, g = b.which, j = w.caret();
                    if (0 == g) {
                        if (j.begin >= n) return w.val(w.val().substr(0, n)), b.preventDefault(), !1;
                        j.begin == j.end && (g = w.val().charCodeAt(j.begin - 1), j.begin--, j.end--);
                    }
                    b.ctrlKey || b.altKey || b.metaKey || 32 > g || g && (0 !== j.end - j.begin && (t(j.begin, j.end), 
                    p(j.begin, j.end - 1)), c = i(j.begin - 1), n > c && (d = String.fromCharCode(g), 
                    k[c].test(d) && (q(c), x[c] = d, u(), f = i(c), h ? setTimeout(a.proxy(a.fn.caret, w, f), 0) :w.caret(f), 
                    e.completed && f >= n && e.completed.call(w))), b.preventDefault());
                }
                function t(a, b) {
                    var c;
                    for (c = a; b > c && n > c; c++) k[c] && (x[c] = e.placeholder);
                }
                function u() {
                    w.val(x.join(""));
                }
                function v(a) {
                    var b, c, d, f = w.val(), g = -1;
                    for (b = 0, d = 0; n > b; b++) if (k[b]) {
                        for (x[b] = e.placeholder; d++ < f.length; ) if (c = f.charAt(d - 1), k[b].test(c)) {
                            x[b] = c, g = b;
                            break;
                        }
                        if (d > f.length) break;
                    } else x[b] === f.charAt(d) && b !== l && (d++, g = b);
                    return a ? u() :l > g + 1 ? e.autoclear || x.join("") === y ? (w.val(""), t(0, n)) :u() :(u(), 
                    w.val(w.val().substring(0, g + 1))), l ? b :m;
                }
                var w = a(this), x = a.map(b.split(""), function(a) {
                    return "?" != a ? j[a] ? e.placeholder :a :void 0;
                }), y = x.join(""), z = w.val();
                w.data(a.mask.dataName, function() {
                    return a.map(x, function(a, b) {
                        return k[b] && a != e.placeholder ? a :null;
                    }).join("");
                }), w.attr("readonly") || w.one("unmask", function() {
                    w.unbind(".mask").removeData(a.mask.dataName);
                }).bind("focus.mask", function() {
                    clearTimeout(c);
                    var a;
                    z = w.val(), a = v(), c = setTimeout(function() {
                        u(), a == b.length ? w.caret(0, a) :w.caret(a);
                    }, 10);
                }).bind("blur.mask", function() {
                    v(), w.val() != z && w.change();
                }).bind("keydown.mask", r).bind("keypress.mask", s).bind(d, function() {
                    setTimeout(function() {
                        var a = v(!0);
                        w.caret(a), e.completed && a == w.val().length && e.completed.call(w);
                    }, 0);
                }), g && h && w.bind("keyup.mask", s), v();
            }));
        }
    });
}(jQuery), function() {
    $(document).on("click", "[rel~='show-offer']", function(event) {
        return event.preventDefault(), $(this).closest($("div[itemscope]")).find("[rel~='offers']").collapse("toggle");
    });
}.call(this), function() {
    $(document).popover({
        selector:"[rel~=popover]"
    }), $(document).tooltip({
        selector:"[rel~=tooltip]"
    }), $(document).on("click", "[rel~=popover]", function(event) {
        return event.preventDefault();
    }), $(document).on("click", "*[data-poload]", function(event) {
        var that;
        return event.preventDefault(), that = $(this), that.data("visible") ? (that.data("visible", !1), 
        that.popover("hide")) :$.get(that.data("poload"), function(d) {
            return that.data("visible", !0), that.popover({
                trigger:"manual",
                content:d
            }).popover("show");
        });
    }), $(function() {
        return bootstrapperize();
    }), $(document).on("page:load", function() {
        return bootstrapperize();
    }), window.bootstrapperize = function() {
        return $("[rel~='checkbox']").each(function() {
            return $(this).is(":checked") ? $(this).parent().addClass("active") :$(this).parent().removeClass("active"), 
            $(this).trigger("custom-change");
        }), $("[rel~='talk-read']").each(function(i, eye) {
            return $("#admin_zone").data("value") ? void 0 :$(eye).closest("fieldset").attr("disabled", "disabled");
        }), $("[rel~='radio']").each(function() {
            return $(this).is(":checked") ? $(this).parent().addClass("active") :$(this).parent().removeClass("active"), 
            $(this).trigger("custom-change");
        }), $("[rel~='select']").each(function() {
            return $(this).trigger("custom-change");
        });
    }, $(document).on("change", "[rel~='radio']", function() {
        return $(this).trigger("custom-change");
    }), $(document).on("change", "[rel~='checkbox']", function() {
        return $(this).trigger("custom-change");
    }), $(document).on("change", "[rel~='select']", function() {
        return $(this).trigger("custom-change");
    });
}.call(this), function() {
    var send_stat;
    $(document).on("page:load", function() {
        return send_stat();
    }), $(function() {
        return window.referrer = document.referrer, send_stat();
    }), send_stat = function() {
        var data, local, offset, server, time, zone;
        return time = $("#server-time").text(), zone = moment().zone(), $("#debug-zone").text(zone), 
        server = moment(time), $("#debug-server").text(server), local = moment(), $("#debug-local").text(local), 
        offset = Math.round((server.diff(local) / 1e3 / 60 + zone) / 60), $("#debug-offset").text(offset), 
        data = {
            stat:{
                location:window.location.href,
                title:document.title,
                referrer:window.referrer,
                russian_time_zone_auto_id:-Math.round(offset),
                screen_width:screen.width,
                screen_height:screen.height,
                client_width:$(window).width(),
                client_height:$(window).height(),
                is_search:$("#is_search").length > 0
            }
        }, window.referrer = window.location.href, $.post("/stats", data, function() {
            return $("#debug-stat-result").removeClass("incomplete").addClass("complete").text(JSON.stringify(data, null, 4));
        });
    };
}.call(this), function() {
    var profileables_buttons;
    $(document).on("page:load", function() {
        return profileables_buttons();
    }), $(function() {
        return profileables_buttons();
    }), profileables_buttons = function() {
        return $(".profileable-category").hover(function() {
            return $(this).find(".profileable-category-add").css("visibility", "visible");
        }, function() {
            return $(this).find(".profileable-category-add").css("visibility", "hidden");
        }), $(".profileable-item").hover(function() {
            return $(this).find(".profileable-item-controls").css("visibility", "visible");
        }, function() {
            return $(this).find(".profileable-item-controls").css("visibility", "hidden");
        });
    };
}.call(this), function() {
    $(document).on("update-mobile-mask", function() {
        return $("[rel~=mobile-mask-on]").mask("+7 (999) 999-99-99"), $("[rel~=mobile-mask-off]").unmask();
    }), $(function() {
        return $(document).trigger("update-mobile-mask");
    }), $(document).on("page:update", function() {
        return $(document).trigger("update-mobile-mask");
    });
}.call(this), function() {
    $(document).on("custom-change", "[rel~='checkbox-mobile']", function() {
        var group;
        return group = $(this).closest(".input-group"), $(this).is(":checked") ? group.find("input[rel|=mobile-mask]").attr("rel", "mobile-mask-on") :group.find("input[rel|=mobile-mask]").attr("rel", "mobile-mask-off"), 
        $(document).trigger("update-mobile-mask");
    });
}.call(this), function() {
    $(document).on("custom-change", "[rel~='checkbox-stand-alone-house']", function() {
        var room;
        return room = $(this).closest("[rel='stand-alone-group']").find("[rel='room']"), 
        $(this).is(":checked") ? room.hide() :room.show();
    });
}.call(this), function() {
    $(document).on("click.collapse-next.data-api", "[data-toggle=collapse-next]", function() {
        var $target;
        return $target = $(this).closest("[rel='collapse-next']").next(), $target.collapse("toggle");
    });
}.call(this), function() {
    $(document).on("custom-change", "input[rel~='radio-new-old-switcher']", function() {
        var block, cur, cur_block, opp, opp_block;
        return $(this).is(":checked") && (block = $(this).closest("[rel~='type-store']"), 
        cur = $(this).val(), opp = "new" === cur ? "old" :"new", cur_block = block.find("[rel~='" + cur + "']"), 
        opp_block = block.find("[rel~='" + opp + "']"), cur_block.show(), opp_block.hide(), 
        "new" !== cur) ? cur_block.find("[rel~=select-and-fill]:input").trigger("custom-change") :void 0;
    });
}.call(this), function() {
    $(function() {
        var right_hand;
        return (right_hand = function() {
            return $("#right_hand").animate({
                left:"5px"
            }).animate({
                left:"0"
            }, {
                complete:function() {
                    return _.delay(right_hand, 1e3);
                }
            });
        })();
    });
}.call(this), function() {
    $(document).on("keypress", '[rel="catch-enter"]', function(e) {
        var $el;
        return 13 === e.which ? (e.preventDefault(), $el = $(this).parent().parent().find('[rel="press-enter"]'), 
        $el.click(), $("#debug-catch-enter").text("true")) :void 0;
    });
}.call(this), function() {
    $(document).on("page:update", function() {
        var selector;
        return selector = "ul.dropdown-menu [data-toggle=dropdown]", $(selector).on("click", function(event) {
            var el, menu, menupos, newpos, _i, _len, _ref;
            for (event.preventDefault(), event.stopPropagation(), _ref = _.difference($(selector).parent().toArray(), $(this).parents().toArray()), 
            _i = 0, _len = _ref.length; _len > _i; _i++) el = _ref[_i], $(el).removeClass("open");
            return $(this).parent().addClass("open"), menu = $(this).parent().find("ul"), menupos = menu.offset(), 
            newpos = menupos.left + menu.width() + 30 > $(window).width() ? -menu.width() :$(this).parent().width(), 
            menu.css({
                left:newpos
            }), !1;
        });
    });
}.call(this), /*
Copyright 2012 Igor Vaynberg

Version: @@ver@@ Timestamp: @@timestamp@@

This software is licensed under the Apache License, Version 2.0 (the "Apache License") or the GNU
General Public License version 2 (the "GPL License"). You may choose either license to govern your
use of this software only upon the condition that you accept all of the terms of either the Apache
License or the GPL License.

You may obtain a copy of the Apache License and the GPL License at:

    http://www.apache.org/licenses/LICENSE-2.0
    http://www.gnu.org/licenses/gpl-2.0.html

Unless required by applicable law or agreed to in writing, software distributed under the
Apache License or the GPL License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the Apache License and the GPL License for
the specific language governing permissions and limitations under the Apache License and the GPL License.
*/
function($) {
    "undefined" == typeof $.fn.each2 && $.extend($.fn, {
        each2:function(c) {
            for (var j = $([ 0 ]), i = -1, l = this.length; ++i < l && (j.context = j[0] = this[i]) && c.call(j[0], i, j) !== !1; ) ;
            return this;
        }
    });
}(jQuery), function($, undefined) {
    "use strict";
    function reinsertElement(element) {
        var placeholder = $(document.createTextNode(""));
        element.before(placeholder), placeholder.before(element), placeholder.remove();
    }
    function stripDiacritics(str) {
        var ret, i, l, c;
        if (!str || str.length < 1) return str;
        for (ret = "", i = 0, l = str.length; l > i; i++) c = str.charAt(i), ret += DIACRITICS[c] || c;
        return ret;
    }
    function indexOf(value, array) {
        for (var i = 0, l = array.length; l > i; i += 1) if (equal(value, array[i])) return i;
        return -1;
    }
    function measureScrollbar() {
        var $template = $(MEASURE_SCROLLBAR_TEMPLATE);
        $template.appendTo("body");
        var dim = {
            width:$template.width() - $template[0].clientWidth,
            height:$template.height() - $template[0].clientHeight
        };
        return $template.remove(), dim;
    }
    function equal(a, b) {
        return a === b ? !0 :a === undefined || b === undefined ? !1 :null === a || null === b ? !1 :a.constructor === String ? a + "" == b + "" :b.constructor === String ? b + "" == a + "" :!1;
    }
    function splitVal(string, separator) {
        var val, i, l;
        if (null === string || string.length < 1) return [];
        for (val = string.split(separator), i = 0, l = val.length; l > i; i += 1) val[i] = $.trim(val[i]);
        return val;
    }
    function getSideBorderPadding(element) {
        return element.outerWidth(!1) - element.width();
    }
    function installKeyUpChangeEvent(element) {
        var key = "keyup-change-value";
        element.on("keydown", function() {
            $.data(element, key) === undefined && $.data(element, key, element.val());
        }), element.on("keyup", function() {
            var val = $.data(element, key);
            val !== undefined && element.val() !== val && ($.removeData(element, key), element.trigger("keyup-change"));
        });
    }
    function installFilteredMouseMove(element) {
        element.on("mousemove", function(e) {
            var lastpos = lastMousePosition;
            (lastpos === undefined || lastpos.x !== e.pageX || lastpos.y !== e.pageY) && $(e.target).trigger("mousemove-filtered", e);
        });
    }
    function debounce(quietMillis, fn, ctx) {
        ctx = ctx || undefined;
        var timeout;
        return function() {
            var args = arguments;
            window.clearTimeout(timeout), timeout = window.setTimeout(function() {
                fn.apply(ctx, args);
            }, quietMillis);
        };
    }
    function thunk(formula) {
        var value, evaluated = !1;
        return function() {
            return evaluated === !1 && (value = formula(), evaluated = !0), value;
        };
    }
    function installDebouncedScroll(threshold, element) {
        var notify = debounce(threshold, function(e) {
            element.trigger("scroll-debounced", e);
        });
        element.on("scroll", function(e) {
            indexOf(e.target, element.get()) >= 0 && notify(e);
        });
    }
    function focus($el) {
        $el[0] !== document.activeElement && window.setTimeout(function() {
            var range, el = $el[0], pos = $el.val().length;
            $el.focus();
            var isVisible = el.offsetWidth > 0 || el.offsetHeight > 0;
            isVisible && el === document.activeElement && (el.setSelectionRange ? el.setSelectionRange(pos, pos) :el.createTextRange && (range = el.createTextRange(), 
            range.collapse(!1), range.select()));
        }, 0);
    }
    function getCursorInfo(el) {
        el = $(el)[0];
        var offset = 0, length = 0;
        if ("selectionStart" in el) offset = el.selectionStart, length = el.selectionEnd - offset; else if ("selection" in document) {
            el.focus();
            var sel = document.selection.createRange();
            length = document.selection.createRange().text.length, sel.moveStart("character", -el.value.length), 
            offset = sel.text.length - length;
        }
        return {
            offset:offset,
            length:length
        };
    }
    function killEvent(event) {
        event.preventDefault(), event.stopPropagation();
    }
    function killEventImmediately(event) {
        event.preventDefault(), event.stopImmediatePropagation();
    }
    function measureTextWidth(e) {
        if (!sizer) {
            var style = e[0].currentStyle || window.getComputedStyle(e[0], null);
            sizer = $(document.createElement("div")).css({
                position:"absolute",
                left:"-10000px",
                top:"-10000px",
                display:"none",
                fontSize:style.fontSize,
                fontFamily:style.fontFamily,
                fontStyle:style.fontStyle,
                fontWeight:style.fontWeight,
                letterSpacing:style.letterSpacing,
                textTransform:style.textTransform,
                whiteSpace:"nowrap"
            }), sizer.attr("class", "select2-sizer"), $("body").append(sizer);
        }
        return sizer.text(e.val()), sizer.width();
    }
    function syncCssClasses(dest, src, adapter) {
        var classes, adapted, replacements = [];
        classes = dest.attr("class"), classes && (classes = "" + classes, $(classes.split(" ")).each2(function() {
            0 === this.indexOf("select2-") && replacements.push(this);
        })), classes = src.attr("class"), classes && (classes = "" + classes, $(classes.split(" ")).each2(function() {
            0 !== this.indexOf("select2-") && (adapted = adapter(this), adapted && replacements.push(adapted));
        })), dest.attr("class", replacements.join(" "));
    }
    function markMatch(text, term, markup, escapeMarkup) {
        var match = stripDiacritics(text.toUpperCase()).indexOf(stripDiacritics(term.toUpperCase())), tl = term.length;
        return 0 > match ? void markup.push(escapeMarkup(text)) :(markup.push(escapeMarkup(text.substring(0, match))), 
        markup.push("<span class='select2-match'>"), markup.push(escapeMarkup(text.substring(match, match + tl))), 
        markup.push("</span>"), void markup.push(escapeMarkup(text.substring(match + tl, text.length))));
    }
    function defaultEscapeMarkup(markup) {
        var replace_map = {
            "\\":"&#92;",
            "&":"&amp;",
            "<":"&lt;",
            ">":"&gt;",
            '"':"&quot;",
            "'":"&#39;",
            "/":"&#47;"
        };
        return String(markup).replace(/[&<>"'\/\\]/g, function(match) {
            return replace_map[match];
        });
    }
    function ajax(options) {
        var timeout, handler = null, quietMillis = options.quietMillis || 100, ajaxUrl = options.url, self = this;
        return function(query) {
            window.clearTimeout(timeout), timeout = window.setTimeout(function() {
                var data = options.data, url = ajaxUrl, transport = options.transport || $.fn.select2.ajaxDefaults.transport, deprecated = {
                    type:options.type || "GET",
                    cache:options.cache || !1,
                    jsonpCallback:options.jsonpCallback || undefined,
                    dataType:options.dataType || "json"
                }, params = $.extend({}, $.fn.select2.ajaxDefaults.params, deprecated);
                data = data ? data.call(self, query.term, query.page, query.context) :null, url = "function" == typeof url ? url.call(self, query.term, query.page, query.context) :url, 
                handler && "function" == typeof handler.abort && handler.abort(), options.params && ($.isFunction(options.params) ? $.extend(params, options.params.call(self)) :$.extend(params, options.params)), 
                $.extend(params, {
                    url:url,
                    dataType:options.dataType,
                    data:data,
                    success:function(data) {
                        var results = options.results(data, query.page);
                        query.callback(results);
                    }
                }), handler = transport.call(self, params);
            }, quietMillis);
        };
    }
    function local(options) {
        var dataText, tmp, data = options, text = function(item) {
            return "" + item.text;
        };
        $.isArray(data) && (tmp = data, data = {
            results:tmp
        }), $.isFunction(data) === !1 && (tmp = data, data = function() {
            return tmp;
        });
        var dataItem = data();
        return dataItem.text && (text = dataItem.text, $.isFunction(text) || (dataText = dataItem.text, 
        text = function(item) {
            return item[dataText];
        })), function(query) {
            var process, t = query.term, filtered = {
                results:[]
            };
            return "" === t ? void query.callback(data()) :(process = function(datum, collection) {
                var group, attr;
                if (datum = datum[0], datum.children) {
                    group = {};
                    for (attr in datum) datum.hasOwnProperty(attr) && (group[attr] = datum[attr]);
                    group.children = [], $(datum.children).each2(function(i, childDatum) {
                        process(childDatum, group.children);
                    }), (group.children.length || query.matcher(t, text(group), datum)) && collection.push(group);
                } else query.matcher(t, text(datum), datum) && collection.push(datum);
            }, $(data().results).each2(function(i, datum) {
                process(datum, filtered.results);
            }), void query.callback(filtered));
        };
    }
    function tags(data) {
        var isFunc = $.isFunction(data);
        return function(query) {
            var t = query.term, filtered = {
                results:[]
            };
            $(isFunc ? data() :data).each(function() {
                var isObject = this.text !== undefined, text = isObject ? this.text :this;
                ("" === t || query.matcher(t, text)) && filtered.results.push(isObject ? this :{
                    id:this,
                    text:this
                });
            }), query.callback(filtered);
        };
    }
    function checkFormatter(formatter, formatterName) {
        if ($.isFunction(formatter)) return !0;
        if (!formatter) return !1;
        throw new Error(formatterName + " must be a function or a falsy value");
    }
    function evaluate(val) {
        return $.isFunction(val) ? val() :val;
    }
    function countResults(results) {
        var count = 0;
        return $.each(results, function(i, item) {
            item.children ? count += countResults(item.children) :count++;
        }), count;
    }
    function defaultTokenizer(input, selection, selectCallback, opts) {
        var token, index, i, l, separator, original = input, dupe = !1;
        if (!opts.createSearchChoice || !opts.tokenSeparators || opts.tokenSeparators.length < 1) return undefined;
        for (;;) {
            for (index = -1, i = 0, l = opts.tokenSeparators.length; l > i && (separator = opts.tokenSeparators[i], 
            index = input.indexOf(separator), !(index >= 0)); i++) ;
            if (0 > index) break;
            if (token = input.substring(0, index), input = input.substring(index + separator.length), 
            token.length > 0 && (token = opts.createSearchChoice.call(this, token, selection), 
            token !== undefined && null !== token && opts.id(token) !== undefined && null !== opts.id(token))) {
                for (dupe = !1, i = 0, l = selection.length; l > i; i++) if (equal(opts.id(token), opts.id(selection[i]))) {
                    dupe = !0;
                    break;
                }
                dupe || selectCallback(token);
            }
        }
        return original !== input ? input :void 0;
    }
    function clazz(SuperClass, methods) {
        var constructor = function() {};
        return constructor.prototype = new SuperClass(), constructor.prototype.constructor = constructor, 
        constructor.prototype.parent = SuperClass.prototype, constructor.prototype = $.extend(constructor.prototype, methods), 
        constructor;
    }
    if (window.Select2 === undefined) {
        var KEY, AbstractSelect2, SingleSelect2, MultiSelect2, nextUid, sizer, $document, scrollBarDimensions, lastMousePosition = {
            x:0,
            y:0
        }, KEY = {
            TAB:9,
            ENTER:13,
            ESC:27,
            SPACE:32,
            LEFT:37,
            UP:38,
            RIGHT:39,
            DOWN:40,
            SHIFT:16,
            CTRL:17,
            ALT:18,
            PAGE_UP:33,
            PAGE_DOWN:34,
            HOME:36,
            END:35,
            BACKSPACE:8,
            DELETE:46,
            isArrow:function(k) {
                switch (k = k.which ? k.which :k) {
                  case KEY.LEFT:
                  case KEY.RIGHT:
                  case KEY.UP:
                  case KEY.DOWN:
                    return !0;
                }
                return !1;
            },
            isControl:function(e) {
                var k = e.which;
                switch (k) {
                  case KEY.SHIFT:
                  case KEY.CTRL:
                  case KEY.ALT:
                    return !0;
                }
                return e.metaKey ? !0 :!1;
            },
            isFunctionKey:function(k) {
                return k = k.which ? k.which :k, k >= 112 && 123 >= k;
            }
        }, MEASURE_SCROLLBAR_TEMPLATE = "<div class='select2-measure-scrollbar'></div>", DIACRITICS = {
            "Ⓐ":"A",
            Ａ:"A",
            À:"A",
            Á:"A",
            Â:"A",
            Ầ:"A",
            Ấ:"A",
            Ẫ:"A",
            Ẩ:"A",
            Ã:"A",
            Ā:"A",
            Ă:"A",
            Ằ:"A",
            Ắ:"A",
            Ẵ:"A",
            Ẳ:"A",
            Ȧ:"A",
            Ǡ:"A",
            Ä:"A",
            Ǟ:"A",
            Ả:"A",
            Å:"A",
            Ǻ:"A",
            Ǎ:"A",
            Ȁ:"A",
            Ȃ:"A",
            Ạ:"A",
            Ậ:"A",
            Ặ:"A",
            Ḁ:"A",
            Ą:"A",
            Ⱥ:"A",
            Ɐ:"A",
            Ꜳ:"AA",
            Æ:"AE",
            Ǽ:"AE",
            Ǣ:"AE",
            Ꜵ:"AO",
            Ꜷ:"AU",
            Ꜹ:"AV",
            Ꜻ:"AV",
            Ꜽ:"AY",
            "Ⓑ":"B",
            Ｂ:"B",
            Ḃ:"B",
            Ḅ:"B",
            Ḇ:"B",
            Ƀ:"B",
            Ƃ:"B",
            Ɓ:"B",
            "Ⓒ":"C",
            Ｃ:"C",
            Ć:"C",
            Ĉ:"C",
            Ċ:"C",
            Č:"C",
            Ç:"C",
            Ḉ:"C",
            Ƈ:"C",
            Ȼ:"C",
            Ꜿ:"C",
            "Ⓓ":"D",
            Ｄ:"D",
            Ḋ:"D",
            Ď:"D",
            Ḍ:"D",
            Ḑ:"D",
            Ḓ:"D",
            Ḏ:"D",
            Đ:"D",
            Ƌ:"D",
            Ɗ:"D",
            Ɖ:"D",
            Ꝺ:"D",
            Ǳ:"DZ",
            Ǆ:"DZ",
            ǲ:"Dz",
            ǅ:"Dz",
            "Ⓔ":"E",
            Ｅ:"E",
            È:"E",
            É:"E",
            Ê:"E",
            Ề:"E",
            Ế:"E",
            Ễ:"E",
            Ể:"E",
            Ẽ:"E",
            Ē:"E",
            Ḕ:"E",
            Ḗ:"E",
            Ĕ:"E",
            Ė:"E",
            Ë:"E",
            Ẻ:"E",
            Ě:"E",
            Ȅ:"E",
            Ȇ:"E",
            Ẹ:"E",
            Ệ:"E",
            Ȩ:"E",
            Ḝ:"E",
            Ę:"E",
            Ḙ:"E",
            Ḛ:"E",
            Ɛ:"E",
            Ǝ:"E",
            "Ⓕ":"F",
            Ｆ:"F",
            Ḟ:"F",
            Ƒ:"F",
            Ꝼ:"F",
            "Ⓖ":"G",
            Ｇ:"G",
            Ǵ:"G",
            Ĝ:"G",
            Ḡ:"G",
            Ğ:"G",
            Ġ:"G",
            Ǧ:"G",
            Ģ:"G",
            Ǥ:"G",
            Ɠ:"G",
            "Ꞡ":"G",
            Ᵹ:"G",
            Ꝿ:"G",
            "Ⓗ":"H",
            Ｈ:"H",
            Ĥ:"H",
            Ḣ:"H",
            Ḧ:"H",
            Ȟ:"H",
            Ḥ:"H",
            Ḩ:"H",
            Ḫ:"H",
            Ħ:"H",
            Ⱨ:"H",
            Ⱶ:"H",
            "Ɥ":"H",
            "Ⓘ":"I",
            Ｉ:"I",
            Ì:"I",
            Í:"I",
            Î:"I",
            Ĩ:"I",
            Ī:"I",
            Ĭ:"I",
            İ:"I",
            Ï:"I",
            Ḯ:"I",
            Ỉ:"I",
            Ǐ:"I",
            Ȉ:"I",
            Ȋ:"I",
            Ị:"I",
            Į:"I",
            Ḭ:"I",
            Ɨ:"I",
            "Ⓙ":"J",
            Ｊ:"J",
            Ĵ:"J",
            Ɉ:"J",
            "Ⓚ":"K",
            Ｋ:"K",
            Ḱ:"K",
            Ǩ:"K",
            Ḳ:"K",
            Ķ:"K",
            Ḵ:"K",
            Ƙ:"K",
            Ⱪ:"K",
            Ꝁ:"K",
            Ꝃ:"K",
            Ꝅ:"K",
            "Ꞣ":"K",
            "Ⓛ":"L",
            Ｌ:"L",
            Ŀ:"L",
            Ĺ:"L",
            Ľ:"L",
            Ḷ:"L",
            Ḹ:"L",
            Ļ:"L",
            Ḽ:"L",
            Ḻ:"L",
            Ł:"L",
            Ƚ:"L",
            Ɫ:"L",
            Ⱡ:"L",
            Ꝉ:"L",
            Ꝇ:"L",
            Ꞁ:"L",
            Ǉ:"LJ",
            ǈ:"Lj",
            "Ⓜ":"M",
            Ｍ:"M",
            Ḿ:"M",
            Ṁ:"M",
            Ṃ:"M",
            Ɱ:"M",
            Ɯ:"M",
            "Ⓝ":"N",
            Ｎ:"N",
            Ǹ:"N",
            Ń:"N",
            Ñ:"N",
            Ṅ:"N",
            Ň:"N",
            Ṇ:"N",
            Ņ:"N",
            Ṋ:"N",
            Ṉ:"N",
            Ƞ:"N",
            Ɲ:"N",
            "Ꞑ":"N",
            "Ꞥ":"N",
            Ǌ:"NJ",
            ǋ:"Nj",
            "Ⓞ":"O",
            Ｏ:"O",
            Ò:"O",
            Ó:"O",
            Ô:"O",
            Ồ:"O",
            Ố:"O",
            Ỗ:"O",
            Ổ:"O",
            Õ:"O",
            Ṍ:"O",
            Ȭ:"O",
            Ṏ:"O",
            Ō:"O",
            Ṑ:"O",
            Ṓ:"O",
            Ŏ:"O",
            Ȯ:"O",
            Ȱ:"O",
            Ö:"O",
            Ȫ:"O",
            Ỏ:"O",
            Ő:"O",
            Ǒ:"O",
            Ȍ:"O",
            Ȏ:"O",
            Ơ:"O",
            Ờ:"O",
            Ớ:"O",
            Ỡ:"O",
            Ở:"O",
            Ợ:"O",
            Ọ:"O",
            Ộ:"O",
            Ǫ:"O",
            Ǭ:"O",
            Ø:"O",
            Ǿ:"O",
            Ɔ:"O",
            Ɵ:"O",
            Ꝋ:"O",
            Ꝍ:"O",
            Ƣ:"OI",
            Ꝏ:"OO",
            Ȣ:"OU",
            "Ⓟ":"P",
            Ｐ:"P",
            Ṕ:"P",
            Ṗ:"P",
            Ƥ:"P",
            Ᵽ:"P",
            Ꝑ:"P",
            Ꝓ:"P",
            Ꝕ:"P",
            "Ⓠ":"Q",
            Ｑ:"Q",
            Ꝗ:"Q",
            Ꝙ:"Q",
            Ɋ:"Q",
            "Ⓡ":"R",
            Ｒ:"R",
            Ŕ:"R",
            Ṙ:"R",
            Ř:"R",
            Ȑ:"R",
            Ȓ:"R",
            Ṛ:"R",
            Ṝ:"R",
            Ŗ:"R",
            Ṟ:"R",
            Ɍ:"R",
            Ɽ:"R",
            Ꝛ:"R",
            "Ꞧ":"R",
            Ꞃ:"R",
            "Ⓢ":"S",
            Ｓ:"S",
            ẞ:"S",
            Ś:"S",
            Ṥ:"S",
            Ŝ:"S",
            Ṡ:"S",
            Š:"S",
            Ṧ:"S",
            Ṣ:"S",
            Ṩ:"S",
            Ș:"S",
            Ş:"S",
            "Ȿ":"S",
            "Ꞩ":"S",
            Ꞅ:"S",
            "Ⓣ":"T",
            Ｔ:"T",
            Ṫ:"T",
            Ť:"T",
            Ṭ:"T",
            Ț:"T",
            Ţ:"T",
            Ṱ:"T",
            Ṯ:"T",
            Ŧ:"T",
            Ƭ:"T",
            Ʈ:"T",
            Ⱦ:"T",
            Ꞇ:"T",
            Ꜩ:"TZ",
            "Ⓤ":"U",
            Ｕ:"U",
            Ù:"U",
            Ú:"U",
            Û:"U",
            Ũ:"U",
            Ṹ:"U",
            Ū:"U",
            Ṻ:"U",
            Ŭ:"U",
            Ü:"U",
            Ǜ:"U",
            Ǘ:"U",
            Ǖ:"U",
            Ǚ:"U",
            Ủ:"U",
            Ů:"U",
            Ű:"U",
            Ǔ:"U",
            Ȕ:"U",
            Ȗ:"U",
            Ư:"U",
            Ừ:"U",
            Ứ:"U",
            Ữ:"U",
            Ử:"U",
            Ự:"U",
            Ụ:"U",
            Ṳ:"U",
            Ų:"U",
            Ṷ:"U",
            Ṵ:"U",
            Ʉ:"U",
            "Ⓥ":"V",
            Ｖ:"V",
            Ṽ:"V",
            Ṿ:"V",
            Ʋ:"V",
            Ꝟ:"V",
            Ʌ:"V",
            Ꝡ:"VY",
            "Ⓦ":"W",
            Ｗ:"W",
            Ẁ:"W",
            Ẃ:"W",
            Ŵ:"W",
            Ẇ:"W",
            Ẅ:"W",
            Ẉ:"W",
            Ⱳ:"W",
            "Ⓧ":"X",
            Ｘ:"X",
            Ẋ:"X",
            Ẍ:"X",
            "Ⓨ":"Y",
            Ｙ:"Y",
            Ỳ:"Y",
            Ý:"Y",
            Ŷ:"Y",
            Ỹ:"Y",
            Ȳ:"Y",
            Ẏ:"Y",
            Ÿ:"Y",
            Ỷ:"Y",
            Ỵ:"Y",
            Ƴ:"Y",
            Ɏ:"Y",
            Ỿ:"Y",
            "Ⓩ":"Z",
            Ｚ:"Z",
            Ź:"Z",
            Ẑ:"Z",
            Ż:"Z",
            Ž:"Z",
            Ẓ:"Z",
            Ẕ:"Z",
            Ƶ:"Z",
            Ȥ:"Z",
            "Ɀ":"Z",
            Ⱬ:"Z",
            Ꝣ:"Z",
            "ⓐ":"a",
            ａ:"a",
            ẚ:"a",
            à:"a",
            á:"a",
            â:"a",
            ầ:"a",
            ấ:"a",
            ẫ:"a",
            ẩ:"a",
            ã:"a",
            ā:"a",
            ă:"a",
            ằ:"a",
            ắ:"a",
            ẵ:"a",
            ẳ:"a",
            ȧ:"a",
            ǡ:"a",
            ä:"a",
            ǟ:"a",
            ả:"a",
            å:"a",
            ǻ:"a",
            ǎ:"a",
            ȁ:"a",
            ȃ:"a",
            ạ:"a",
            ậ:"a",
            ặ:"a",
            ḁ:"a",
            ą:"a",
            ⱥ:"a",
            ɐ:"a",
            ꜳ:"aa",
            æ:"ae",
            ǽ:"ae",
            ǣ:"ae",
            ꜵ:"ao",
            ꜷ:"au",
            ꜹ:"av",
            ꜻ:"av",
            ꜽ:"ay",
            "ⓑ":"b",
            ｂ:"b",
            ḃ:"b",
            ḅ:"b",
            ḇ:"b",
            ƀ:"b",
            ƃ:"b",
            ɓ:"b",
            "ⓒ":"c",
            ｃ:"c",
            ć:"c",
            ĉ:"c",
            ċ:"c",
            č:"c",
            ç:"c",
            ḉ:"c",
            ƈ:"c",
            ȼ:"c",
            ꜿ:"c",
            ↄ:"c",
            "ⓓ":"d",
            ｄ:"d",
            ḋ:"d",
            ď:"d",
            ḍ:"d",
            ḑ:"d",
            ḓ:"d",
            ḏ:"d",
            đ:"d",
            ƌ:"d",
            ɖ:"d",
            ɗ:"d",
            ꝺ:"d",
            ǳ:"dz",
            ǆ:"dz",
            "ⓔ":"e",
            ｅ:"e",
            è:"e",
            é:"e",
            ê:"e",
            ề:"e",
            ế:"e",
            ễ:"e",
            ể:"e",
            ẽ:"e",
            ē:"e",
            ḕ:"e",
            ḗ:"e",
            ĕ:"e",
            ė:"e",
            ë:"e",
            ẻ:"e",
            ě:"e",
            ȅ:"e",
            ȇ:"e",
            ẹ:"e",
            ệ:"e",
            ȩ:"e",
            ḝ:"e",
            ę:"e",
            ḙ:"e",
            ḛ:"e",
            ɇ:"e",
            ɛ:"e",
            ǝ:"e",
            "ⓕ":"f",
            ｆ:"f",
            ḟ:"f",
            ƒ:"f",
            ꝼ:"f",
            "ⓖ":"g",
            ｇ:"g",
            ǵ:"g",
            ĝ:"g",
            ḡ:"g",
            ğ:"g",
            ġ:"g",
            ǧ:"g",
            ģ:"g",
            ǥ:"g",
            ɠ:"g",
            "ꞡ":"g",
            ᵹ:"g",
            ꝿ:"g",
            "ⓗ":"h",
            ｈ:"h",
            ĥ:"h",
            ḣ:"h",
            ḧ:"h",
            ȟ:"h",
            ḥ:"h",
            ḩ:"h",
            ḫ:"h",
            ẖ:"h",
            ħ:"h",
            ⱨ:"h",
            ⱶ:"h",
            ɥ:"h",
            ƕ:"hv",
            "ⓘ":"i",
            ｉ:"i",
            ì:"i",
            í:"i",
            î:"i",
            ĩ:"i",
            ī:"i",
            ĭ:"i",
            ï:"i",
            ḯ:"i",
            ỉ:"i",
            ǐ:"i",
            ȉ:"i",
            ȋ:"i",
            ị:"i",
            į:"i",
            ḭ:"i",
            ɨ:"i",
            ı:"i",
            "ⓙ":"j",
            ｊ:"j",
            ĵ:"j",
            ǰ:"j",
            ɉ:"j",
            "ⓚ":"k",
            ｋ:"k",
            ḱ:"k",
            ǩ:"k",
            ḳ:"k",
            ķ:"k",
            ḵ:"k",
            ƙ:"k",
            ⱪ:"k",
            ꝁ:"k",
            ꝃ:"k",
            ꝅ:"k",
            "ꞣ":"k",
            "ⓛ":"l",
            ｌ:"l",
            ŀ:"l",
            ĺ:"l",
            ľ:"l",
            ḷ:"l",
            ḹ:"l",
            ļ:"l",
            ḽ:"l",
            ḻ:"l",
            ſ:"l",
            ł:"l",
            ƚ:"l",
            ɫ:"l",
            ⱡ:"l",
            ꝉ:"l",
            ꞁ:"l",
            ꝇ:"l",
            ǉ:"lj",
            "ⓜ":"m",
            ｍ:"m",
            ḿ:"m",
            ṁ:"m",
            ṃ:"m",
            ɱ:"m",
            ɯ:"m",
            "ⓝ":"n",
            ｎ:"n",
            ǹ:"n",
            ń:"n",
            ñ:"n",
            ṅ:"n",
            ň:"n",
            ṇ:"n",
            ņ:"n",
            ṋ:"n",
            ṉ:"n",
            ƞ:"n",
            ɲ:"n",
            ŉ:"n",
            "ꞑ":"n",
            "ꞥ":"n",
            ǌ:"nj",
            "ⓞ":"o",
            ｏ:"o",
            ò:"o",
            ó:"o",
            ô:"o",
            ồ:"o",
            ố:"o",
            ỗ:"o",
            ổ:"o",
            õ:"o",
            ṍ:"o",
            ȭ:"o",
            ṏ:"o",
            ō:"o",
            ṑ:"o",
            ṓ:"o",
            ŏ:"o",
            ȯ:"o",
            ȱ:"o",
            ö:"o",
            ȫ:"o",
            ỏ:"o",
            ő:"o",
            ǒ:"o",
            ȍ:"o",
            ȏ:"o",
            ơ:"o",
            ờ:"o",
            ớ:"o",
            ỡ:"o",
            ở:"o",
            ợ:"o",
            ọ:"o",
            ộ:"o",
            ǫ:"o",
            ǭ:"o",
            ø:"o",
            ǿ:"o",
            ɔ:"o",
            ꝋ:"o",
            ꝍ:"o",
            ɵ:"o",
            ƣ:"oi",
            ȣ:"ou",
            ꝏ:"oo",
            "ⓟ":"p",
            ｐ:"p",
            ṕ:"p",
            ṗ:"p",
            ƥ:"p",
            ᵽ:"p",
            ꝑ:"p",
            ꝓ:"p",
            ꝕ:"p",
            "ⓠ":"q",
            ｑ:"q",
            ɋ:"q",
            ꝗ:"q",
            ꝙ:"q",
            "ⓡ":"r",
            ｒ:"r",
            ŕ:"r",
            ṙ:"r",
            ř:"r",
            ȑ:"r",
            ȓ:"r",
            ṛ:"r",
            ṝ:"r",
            ŗ:"r",
            ṟ:"r",
            ɍ:"r",
            ɽ:"r",
            ꝛ:"r",
            "ꞧ":"r",
            ꞃ:"r",
            "ⓢ":"s",
            ｓ:"s",
            ß:"s",
            ś:"s",
            ṥ:"s",
            ŝ:"s",
            ṡ:"s",
            š:"s",
            ṧ:"s",
            ṣ:"s",
            ṩ:"s",
            ș:"s",
            ş:"s",
            ȿ:"s",
            "ꞩ":"s",
            ꞅ:"s",
            ẛ:"s",
            "ⓣ":"t",
            ｔ:"t",
            ṫ:"t",
            ẗ:"t",
            ť:"t",
            ṭ:"t",
            ț:"t",
            ţ:"t",
            ṱ:"t",
            ṯ:"t",
            ŧ:"t",
            ƭ:"t",
            ʈ:"t",
            ⱦ:"t",
            ꞇ:"t",
            ꜩ:"tz",
            "ⓤ":"u",
            ｕ:"u",
            ù:"u",
            ú:"u",
            û:"u",
            ũ:"u",
            ṹ:"u",
            ū:"u",
            ṻ:"u",
            ŭ:"u",
            ü:"u",
            ǜ:"u",
            ǘ:"u",
            ǖ:"u",
            ǚ:"u",
            ủ:"u",
            ů:"u",
            ű:"u",
            ǔ:"u",
            ȕ:"u",
            ȗ:"u",
            ư:"u",
            ừ:"u",
            ứ:"u",
            ữ:"u",
            ử:"u",
            ự:"u",
            ụ:"u",
            ṳ:"u",
            ų:"u",
            ṷ:"u",
            ṵ:"u",
            ʉ:"u",
            "ⓥ":"v",
            ｖ:"v",
            ṽ:"v",
            ṿ:"v",
            ʋ:"v",
            ꝟ:"v",
            ʌ:"v",
            ꝡ:"vy",
            "ⓦ":"w",
            ｗ:"w",
            ẁ:"w",
            ẃ:"w",
            ŵ:"w",
            ẇ:"w",
            ẅ:"w",
            ẘ:"w",
            ẉ:"w",
            ⱳ:"w",
            "ⓧ":"x",
            ｘ:"x",
            ẋ:"x",
            ẍ:"x",
            "ⓨ":"y",
            ｙ:"y",
            ỳ:"y",
            ý:"y",
            ŷ:"y",
            ỹ:"y",
            ȳ:"y",
            ẏ:"y",
            ÿ:"y",
            ỷ:"y",
            ẙ:"y",
            ỵ:"y",
            ƴ:"y",
            ɏ:"y",
            ỿ:"y",
            "ⓩ":"z",
            ｚ:"z",
            ź:"z",
            ẑ:"z",
            ż:"z",
            ž:"z",
            ẓ:"z",
            ẕ:"z",
            ƶ:"z",
            ȥ:"z",
            ɀ:"z",
            ⱬ:"z",
            ꝣ:"z"
        };
        $document = $(document), nextUid = function() {
            var counter = 1;
            return function() {
                return counter++;
            };
        }(), $document.on("mousemove", function(e) {
            lastMousePosition.x = e.pageX, lastMousePosition.y = e.pageY;
        }), AbstractSelect2 = clazz(Object, {
            bind:function(func) {
                var self = this;
                return function() {
                    func.apply(self, arguments);
                };
            },
            init:function(opts) {
                var results, search, resultsSelector = ".select2-results";
                this.opts = opts = this.prepareOpts(opts), this.id = opts.id, opts.element.data("select2") !== undefined && null !== opts.element.data("select2") && opts.element.data("select2").destroy(), 
                this.container = this.createContainer(), this.liveRegion = $("<span>", {
                    role:"status",
                    "aria-live":"polite"
                }).addClass("select2-hidden-accessible").appendTo(document.body), this.containerId = "s2id_" + (opts.element.attr("id") || "autogen" + nextUid()).replace(/([;&,\-\.\+\*\~':"\!\^#$%@\[\]\(\)=>\|])/g, "\\$1"), 
                this.containerSelector = "#" + this.containerId, this.container.attr("id", this.containerId), 
                this.body = thunk(function() {
                    return opts.element.closest("body");
                }), syncCssClasses(this.container, this.opts.element, this.opts.adaptContainerCssClass), 
                this.container.attr("style", opts.element.attr("style")), this.container.css(evaluate(opts.containerCss)), 
                this.container.addClass(evaluate(opts.containerCssClass)), this.elementTabIndex = this.opts.element.attr("tabindex"), 
                this.opts.element.data("select2", this).attr("tabindex", "-1").before(this.container).on("click.select2", killEvent), 
                this.container.data("select2", this), this.dropdown = this.container.find(".select2-drop"), 
                syncCssClasses(this.dropdown, this.opts.element, this.opts.adaptDropdownCssClass), 
                this.dropdown.addClass(evaluate(opts.dropdownCssClass)), this.dropdown.data("select2", this), 
                this.dropdown.on("click", killEvent), this.results = results = this.container.find(resultsSelector), 
                this.search = search = this.container.find("input.select2-input"), this.queryCount = 0, 
                this.resultsPage = 0, this.context = null, this.initContainer(), this.container.on("click", killEvent), 
                installFilteredMouseMove(this.results), this.dropdown.on("mousemove-filtered touchstart touchmove touchend", resultsSelector, this.bind(this.highlightUnderEvent)), 
                installDebouncedScroll(80, this.results), this.dropdown.on("scroll-debounced", resultsSelector, this.bind(this.loadMoreIfNeeded)), 
                $(this.container).on("change", ".select2-input", function(e) {
                    e.stopPropagation();
                }), $(this.dropdown).on("change", ".select2-input", function(e) {
                    e.stopPropagation();
                }), $.fn.mousewheel && results.mousewheel(function(e, delta, deltaX, deltaY) {
                    var top = results.scrollTop();
                    deltaY > 0 && 0 >= top - deltaY ? (results.scrollTop(0), killEvent(e)) :0 > deltaY && results.get(0).scrollHeight - results.scrollTop() + deltaY <= results.height() && (results.scrollTop(results.get(0).scrollHeight - results.height()), 
                    killEvent(e));
                }), installKeyUpChangeEvent(search), search.on("keyup-change input paste", this.bind(this.updateResults)), 
                search.on("focus", function() {
                    search.addClass("select2-focused");
                }), search.on("blur", function() {
                    search.removeClass("select2-focused");
                }), this.dropdown.on("mouseup", resultsSelector, this.bind(function(e) {
                    $(e.target).closest(".select2-result-selectable").length > 0 && (this.highlightUnderEvent(e), 
                    this.selectHighlighted(e));
                })), this.dropdown.on("click mouseup mousedown", function(e) {
                    e.stopPropagation();
                }), this.nextSearchTerm = undefined, $.isFunction(this.opts.initSelection) && (this.initSelection(), 
                this.monitorSource()), null !== opts.maximumInputLength && this.search.attr("maxlength", opts.maximumInputLength);
                var disabled = opts.element.prop("disabled");
                disabled === undefined && (disabled = !1), this.enable(!disabled);
                var readonly = opts.element.prop("readonly");
                readonly === undefined && (readonly = !1), this.readonly(readonly), scrollBarDimensions = scrollBarDimensions || measureScrollbar(), 
                this.autofocus = opts.element.prop("autofocus"), opts.element.prop("autofocus", !1), 
                this.autofocus && this.focus(), this.search.attr("placeholder", opts.searchInputPlaceholder);
            },
            destroy:function() {
                var element = this.opts.element, select2 = element.data("select2");
                this.close(), this.propertyObserver && (delete this.propertyObserver, this.propertyObserver = null), 
                select2 !== undefined && (select2.container.remove(), select2.liveRegion.remove(), 
                select2.dropdown.remove(), element.removeClass("select2-offscreen").removeData("select2").off(".select2").prop("autofocus", this.autofocus || !1), 
                this.elementTabIndex ? element.attr({
                    tabindex:this.elementTabIndex
                }) :element.removeAttr("tabindex"), element.show());
            },
            optionToData:function(element) {
                return element.is("option") ? {
                    id:element.prop("value"),
                    text:element.text(),
                    element:element.get(),
                    css:element.attr("class"),
                    disabled:element.prop("disabled"),
                    locked:equal(element.attr("locked"), "locked") || equal(element.data("locked"), !0)
                } :element.is("optgroup") ? {
                    text:element.attr("label"),
                    children:[],
                    element:element.get(),
                    css:element.attr("class")
                } :void 0;
            },
            prepareOpts:function(opts) {
                var element, select, idKey, ajaxUrl, self = this;
                if (element = opts.element, "select" === element.get(0).tagName.toLowerCase() && (this.select = select = opts.element), 
                select && $.each([ "id", "multiple", "ajax", "query", "createSearchChoice", "initSelection", "data", "tags" ], function() {
                    if (this in opts) throw new Error("Option '" + this + "' is not allowed for Select2 when attached to a <select> element.");
                }), opts = $.extend({}, {
                    populateResults:function(container, results, query) {
                        var populate, id = this.opts.id, liveRegion = this.liveRegion;
                        (populate = function(results, container, depth) {
                            var i, l, result, selectable, disabled, compound, node, label, innerContainer, formatted;
                            for (results = opts.sortResults(results, container, query), i = 0, l = results.length; l > i; i += 1) result = results[i], 
                            disabled = result.disabled === !0, selectable = !disabled && id(result) !== undefined, 
                            compound = result.children && result.children.length > 0, node = $("<li></li>"), 
                            node.addClass("select2-results-dept-" + depth), node.addClass("select2-result"), 
                            node.addClass(selectable ? "select2-result-selectable" :"select2-result-unselectable"), 
                            disabled && node.addClass("select2-disabled"), compound && node.addClass("select2-result-with-children"), 
                            node.addClass(self.opts.formatResultCssClass(result)), node.attr("role", "presentation"), 
                            label = $(document.createElement("div")), label.addClass("select2-result-label"), 
                            label.attr("id", "select2-result-label-" + nextUid()), label.attr("role", "option"), 
                            formatted = opts.formatResult(result, label, query, self.opts.escapeMarkup), formatted !== undefined && (label.html(formatted), 
                            node.append(label)), compound && (innerContainer = $("<ul></ul>"), innerContainer.addClass("select2-result-sub"), 
                            populate(result.children, innerContainer, depth + 1), node.append(innerContainer)), 
                            node.data("select2-data", result), container.append(node);
                            liveRegion.text(opts.formatMatches(results.length));
                        })(results, container, 0);
                    }
                }, $.fn.select2.defaults, opts), "function" != typeof opts.id && (idKey = opts.id, 
                opts.id = function(e) {
                    return e[idKey];
                }), $.isArray(opts.element.data("select2Tags"))) {
                    if ("tags" in opts) throw "tags specified as both an attribute 'data-select2-tags' and in options of Select2 " + opts.element.attr("id");
                    opts.tags = opts.element.data("select2Tags");
                }
                if (select ? (opts.query = this.bind(function(query) {
                    var children, placeholderOption, process, data = {
                        results:[],
                        more:!1
                    }, term = query.term;
                    process = function(element, collection) {
                        var group;
                        element.is("option") ? query.matcher(term, element.text(), element) && collection.push(self.optionToData(element)) :element.is("optgroup") && (group = self.optionToData(element), 
                        element.children().each2(function(i, elm) {
                            process(elm, group.children);
                        }), group.children.length > 0 && collection.push(group));
                    }, children = element.children(), this.getPlaceholder() !== undefined && children.length > 0 && (placeholderOption = this.getPlaceholderOption(), 
                    placeholderOption && (children = children.not(placeholderOption))), children.each2(function(i, elm) {
                        process(elm, data.results);
                    }), query.callback(data);
                }), opts.id = function(e) {
                    return e.id;
                }) :"query" in opts || ("ajax" in opts ? (ajaxUrl = opts.element.data("ajax-url"), 
                ajaxUrl && ajaxUrl.length > 0 && (opts.ajax.url = ajaxUrl), opts.query = ajax.call(opts.element, opts.ajax)) :"data" in opts ? opts.query = local(opts.data) :"tags" in opts && (opts.query = tags(opts.tags), 
                opts.createSearchChoice === undefined && (opts.createSearchChoice = function(term) {
                    return {
                        id:$.trim(term),
                        text:$.trim(term)
                    };
                }), opts.initSelection === undefined && (opts.initSelection = function(element, callback) {
                    var data = [];
                    $(splitVal(element.val(), opts.separator)).each(function() {
                        var obj = {
                            id:this,
                            text:this
                        }, tags = opts.tags;
                        $.isFunction(tags) && (tags = tags()), $(tags).each(function() {
                            return equal(this.id, obj.id) ? (obj = this, !1) :void 0;
                        }), data.push(obj);
                    }), callback(data);
                }))), "function" != typeof opts.query) throw "query function not defined for Select2 " + opts.element.attr("id");
                if ("top" === opts.createSearchChoicePosition) opts.createSearchChoicePosition = function(list, item) {
                    list.unshift(item);
                }; else if ("bottom" === opts.createSearchChoicePosition) opts.createSearchChoicePosition = function(list, item) {
                    list.push(item);
                }; else if ("function" != typeof opts.createSearchChoicePosition) throw "invalid createSearchChoicePosition option must be 'top', 'bottom' or a custom function";
                return opts;
            },
            monitorSource:function() {
                var sync, observer, el = this.opts.element;
                el.on("change.select2", this.bind(function() {
                    this.opts.element.data("select2-change-triggered") !== !0 && this.initSelection();
                })), sync = this.bind(function() {
                    var disabled = el.prop("disabled");
                    disabled === undefined && (disabled = !1), this.enable(!disabled);
                    var readonly = el.prop("readonly");
                    readonly === undefined && (readonly = !1), this.readonly(readonly), syncCssClasses(this.container, this.opts.element, this.opts.adaptContainerCssClass), 
                    this.container.addClass(evaluate(this.opts.containerCssClass)), syncCssClasses(this.dropdown, this.opts.element, this.opts.adaptDropdownCssClass), 
                    this.dropdown.addClass(evaluate(this.opts.dropdownCssClass));
                }), el.on("propertychange.select2", sync), this.mutationCallback === undefined && (this.mutationCallback = function(mutations) {
                    mutations.forEach(sync);
                }), observer = window.MutationObserver || window.WebKitMutationObserver || window.MozMutationObserver, 
                observer !== undefined && (this.propertyObserver && (delete this.propertyObserver, 
                this.propertyObserver = null), this.propertyObserver = new observer(this.mutationCallback), 
                this.propertyObserver.observe(el.get(0), {
                    attributes:!0,
                    subtree:!1
                }));
            },
            triggerSelect:function(data) {
                var evt = $.Event("select2-selecting", {
                    val:this.id(data),
                    object:data
                });
                return this.opts.element.trigger(evt), !evt.isDefaultPrevented();
            },
            triggerChange:function(details) {
                details = details || {}, details = $.extend({}, details, {
                    type:"change",
                    val:this.val()
                }), this.opts.element.data("select2-change-triggered", !0), this.opts.element.trigger(details), 
                this.opts.element.data("select2-change-triggered", !1), this.opts.element.click(), 
                this.opts.blurOnChange && this.opts.element.blur();
            },
            isInterfaceEnabled:function() {
                return this.enabledInterface === !0;
            },
            enableInterface:function() {
                var enabled = this._enabled && !this._readonly, disabled = !enabled;
                return enabled === this.enabledInterface ? !1 :(this.container.toggleClass("select2-container-disabled", disabled), 
                this.close(), this.enabledInterface = enabled, !0);
            },
            enable:function(enabled) {
                enabled === undefined && (enabled = !0), this._enabled !== enabled && (this._enabled = enabled, 
                this.opts.element.prop("disabled", !enabled), this.enableInterface());
            },
            disable:function() {
                this.enable(!1);
            },
            readonly:function(enabled) {
                return enabled === undefined && (enabled = !1), this._readonly === enabled ? !1 :(this._readonly = enabled, 
                this.opts.element.prop("readonly", enabled), this.enableInterface(), !0);
            },
            opened:function() {
                return this.container.hasClass("select2-dropdown-open");
            },
            positionDropdown:function() {
                var bodyOffset, above, changeDirection, css, resultsListNode, $dropdown = this.dropdown, offset = this.container.offset(), height = this.container.outerHeight(!1), width = this.container.outerWidth(!1), dropHeight = $dropdown.outerHeight(!1), $window = $(window), windowWidth = $window.width(), windowHeight = $window.height(), viewPortRight = $window.scrollLeft() + windowWidth, viewportBottom = $window.scrollTop() + windowHeight, dropTop = offset.top + height, dropLeft = offset.left, enoughRoomBelow = viewportBottom >= dropTop + dropHeight, enoughRoomAbove = offset.top - dropHeight >= this.body().scrollTop(), dropWidth = $dropdown.outerWidth(!1), enoughRoomOnRight = viewPortRight >= dropLeft + dropWidth, aboveNow = $dropdown.hasClass("select2-drop-above");
                aboveNow ? (above = !0, !enoughRoomAbove && enoughRoomBelow && (changeDirection = !0, 
                above = !1)) :(above = !1, !enoughRoomBelow && enoughRoomAbove && (changeDirection = !0, 
                above = !0)), changeDirection && ($dropdown.hide(), offset = this.container.offset(), 
                height = this.container.outerHeight(!1), width = this.container.outerWidth(!1), 
                dropHeight = $dropdown.outerHeight(!1), viewPortRight = $window.scrollLeft() + windowWidth, 
                viewportBottom = $window.scrollTop() + windowHeight, dropTop = offset.top + height, 
                dropLeft = offset.left, dropWidth = $dropdown.outerWidth(!1), enoughRoomOnRight = viewPortRight >= dropLeft + dropWidth, 
                $dropdown.show()), this.opts.dropdownAutoWidth ? (resultsListNode = $(".select2-results", $dropdown)[0], 
                $dropdown.addClass("select2-drop-auto-width"), $dropdown.css("width", ""), dropWidth = $dropdown.outerWidth(!1) + (resultsListNode.scrollHeight === resultsListNode.clientHeight ? 0 :scrollBarDimensions.width), 
                dropWidth > width ? width = dropWidth :dropWidth = width, enoughRoomOnRight = viewPortRight >= dropLeft + dropWidth) :this.container.removeClass("select2-drop-auto-width"), 
                "static" !== this.body().css("position") && (bodyOffset = this.body().offset(), 
                dropTop -= bodyOffset.top, dropLeft -= bodyOffset.left), enoughRoomOnRight || (dropLeft = offset.left + this.container.outerWidth(!1) - dropWidth), 
                css = {
                    left:dropLeft,
                    width:width
                }, above ? (css.top = offset.top - dropHeight, css.bottom = "auto", this.container.addClass("select2-drop-above"), 
                $dropdown.addClass("select2-drop-above")) :(css.top = dropTop, css.bottom = "auto", 
                this.container.removeClass("select2-drop-above"), $dropdown.removeClass("select2-drop-above")), 
                css = $.extend(css, evaluate(this.opts.dropdownCss)), $dropdown.css(css);
            },
            shouldOpen:function() {
                var event;
                return this.opened() ? !1 :this._enabled === !1 || this._readonly === !0 ? !1 :(event = $.Event("select2-opening"), 
                this.opts.element.trigger(event), !event.isDefaultPrevented());
            },
            clearDropdownAlignmentPreference:function() {
                this.container.removeClass("select2-drop-above"), this.dropdown.removeClass("select2-drop-above");
            },
            open:function() {
                return this.shouldOpen() ? (this.opening(), !0) :!1;
            },
            opening:function() {
                var mask, cid = this.containerId, scroll = "scroll." + cid, resize = "resize." + cid, orient = "orientationchange." + cid;
                this.container.addClass("select2-dropdown-open").addClass("select2-container-active"), 
                this.clearDropdownAlignmentPreference(), this.dropdown[0] !== this.body().children().last()[0] && this.dropdown.detach().appendTo(this.body()), 
                mask = $("#select2-drop-mask"), 0 == mask.length && (mask = $(document.createElement("div")), 
                mask.attr("id", "select2-drop-mask").attr("class", "select2-drop-mask"), mask.hide(), 
                mask.appendTo(this.body()), mask.on("mousedown touchstart click", function(e) {
                    reinsertElement(mask);
                    var self, dropdown = $("#select2-drop");
                    dropdown.length > 0 && (self = dropdown.data("select2"), self.opts.selectOnBlur && self.selectHighlighted({
                        noFocus:!0
                    }), self.close({
                        focus:!0
                    }), e.preventDefault(), e.stopPropagation());
                })), this.dropdown.prev()[0] !== mask[0] && this.dropdown.before(mask), $("#select2-drop").removeAttr("id"), 
                this.dropdown.attr("id", "select2-drop"), mask.show(), this.positionDropdown(), 
                this.dropdown.show(), this.positionDropdown(), this.dropdown.addClass("select2-drop-active");
                var that = this;
                this.container.parents().add(window).each(function() {
                    $(this).on(resize + " " + scroll + " " + orient, function() {
                        that.positionDropdown();
                    });
                });
            },
            close:function() {
                if (this.opened()) {
                    var cid = this.containerId, scroll = "scroll." + cid, resize = "resize." + cid, orient = "orientationchange." + cid;
                    this.container.parents().add(window).each(function() {
                        $(this).off(scroll).off(resize).off(orient);
                    }), this.clearDropdownAlignmentPreference(), $("#select2-drop-mask").hide(), this.dropdown.removeAttr("id"), 
                    this.dropdown.hide(), this.container.removeClass("select2-dropdown-open").removeClass("select2-container-active"), 
                    this.results.empty(), this.clearSearch(), this.search.removeClass("select2-active"), 
                    this.opts.element.trigger($.Event("select2-close"));
                }
            },
            externalSearch:function(term) {
                this.open(), this.search.val(term), this.updateResults(!1);
            },
            clearSearch:function() {},
            getMaximumSelectionSize:function() {
                return evaluate(this.opts.maximumSelectionSize);
            },
            ensureHighlightVisible:function() {
                var children, index, child, hb, rb, y, more, results = this.results;
                if (index = this.highlight(), !(0 > index)) {
                    if (0 == index) return void results.scrollTop(0);
                    children = this.findHighlightableChoices().find(".select2-result-label"), child = $(children[index]), 
                    hb = child.offset().top + child.outerHeight(!0), index === children.length - 1 && (more = results.find("li.select2-more-results"), 
                    more.length > 0 && (hb = more.offset().top + more.outerHeight(!0))), rb = results.offset().top + results.outerHeight(!0), 
                    hb > rb && results.scrollTop(results.scrollTop() + (hb - rb)), y = child.offset().top - results.offset().top, 
                    0 > y && "none" != child.css("display") && results.scrollTop(results.scrollTop() + y);
                }
            },
            findHighlightableChoices:function() {
                return this.results.find(".select2-result-selectable:not(.select2-disabled):not(.select2-selected)");
            },
            moveHighlight:function(delta) {
                for (var choices = this.findHighlightableChoices(), index = this.highlight(); index > -1 && index < choices.length; ) {
                    index += delta;
                    var choice = $(choices[index]);
                    if (choice.hasClass("select2-result-selectable") && !choice.hasClass("select2-disabled") && !choice.hasClass("select2-selected")) {
                        this.highlight(index);
                        break;
                    }
                }
            },
            highlight:function(index) {
                var choice, data, choices = this.findHighlightableChoices();
                return 0 === arguments.length ? indexOf(choices.filter(".select2-highlighted")[0], choices.get()) :(index >= choices.length && (index = choices.length - 1), 
                0 > index && (index = 0), this.removeHighlight(), choice = $(choices[index]), choice.addClass("select2-highlighted"), 
                this.search.attr("aria-activedescendant", choice.find(".select2-result-label").attr("id")), 
                this.ensureHighlightVisible(), this.liveRegion.text(choice.text()), data = choice.data("select2-data"), 
                void (data && this.opts.element.trigger({
                    type:"select2-highlight",
                    val:this.id(data),
                    choice:data
                })));
            },
            removeHighlight:function() {
                this.results.find(".select2-highlighted").removeClass("select2-highlighted");
            },
            countSelectableResults:function() {
                return this.findHighlightableChoices().length;
            },
            highlightUnderEvent:function(event) {
                var el = $(event.target).closest(".select2-result-selectable");
                if (el.length > 0 && !el.is(".select2-highlighted")) {
                    var choices = this.findHighlightableChoices();
                    this.highlight(choices.index(el));
                } else 0 == el.length && this.removeHighlight();
            },
            loadMoreIfNeeded:function() {
                var below, results = this.results, more = results.find("li.select2-more-results"), page = this.resultsPage + 1, self = this, term = this.search.val(), context = this.context;
                0 !== more.length && (below = more.offset().top - results.offset().top - results.height(), 
                below <= this.opts.loadMorePadding && (more.addClass("select2-active"), this.opts.query({
                    element:this.opts.element,
                    term:term,
                    page:page,
                    context:context,
                    matcher:this.opts.matcher,
                    callback:this.bind(function(data) {
                        self.opened() && (self.opts.populateResults.call(this, results, data.results, {
                            term:term,
                            page:page,
                            context:context
                        }), self.postprocessResults(data, !1, !1), data.more === !0 ? (more.detach().appendTo(results).text(self.opts.formatLoadMore(page + 1)), 
                        window.setTimeout(function() {
                            self.loadMoreIfNeeded();
                        }, 10)) :more.remove(), self.positionDropdown(), self.resultsPage = page, self.context = data.context, 
                        this.opts.element.trigger({
                            type:"select2-loaded",
                            items:data
                        }));
                    })
                })));
            },
            tokenize:function() {},
            updateResults:function(initial) {
                function postRender() {
                    search.removeClass("select2-active"), self.positionDropdown(), self.liveRegion.text(results.find(".select2-no-results,.select2-selection-limit,.select2-searching").length ? results.text() :self.opts.formatMatches(results.find(".select2-result-selectable").length));
                }
                function render(html) {
                    results.html(html), postRender();
                }
                var data, input, queryNumber, search = this.search, results = this.results, opts = this.opts, self = this, term = search.val(), lastTerm = $.data(this.container, "select2-last-term");
                if ((initial === !0 || !lastTerm || !equal(term, lastTerm)) && ($.data(this.container, "select2-last-term", term), 
                initial === !0 || this.showSearchInput !== !1 && this.opened())) {
                    queryNumber = ++this.queryCount;
                    var maxSelSize = this.getMaximumSelectionSize();
                    if (maxSelSize >= 1 && (data = this.data(), $.isArray(data) && data.length >= maxSelSize && checkFormatter(opts.formatSelectionTooBig, "formatSelectionTooBig"))) return void render("<li class='select2-selection-limit'>" + opts.formatSelectionTooBig(maxSelSize) + "</li>");
                    if (search.val().length < opts.minimumInputLength) return render(checkFormatter(opts.formatInputTooShort, "formatInputTooShort") ? "<li class='select2-no-results'>" + opts.formatInputTooShort(search.val(), opts.minimumInputLength) + "</li>" :""), 
                    void (initial && this.showSearch && this.showSearch(!0));
                    if (opts.maximumInputLength && search.val().length > opts.maximumInputLength) return void render(checkFormatter(opts.formatInputTooLong, "formatInputTooLong") ? "<li class='select2-no-results'>" + opts.formatInputTooLong(search.val(), opts.maximumInputLength) + "</li>" :"");
                    opts.formatSearching && 0 === this.findHighlightableChoices().length && render("<li class='select2-searching'>" + opts.formatSearching() + "</li>"), 
                    search.addClass("select2-active"), this.removeHighlight(), input = this.tokenize(), 
                    input != undefined && null != input && search.val(input), this.resultsPage = 1, 
                    opts.query({
                        element:opts.element,
                        term:search.val(),
                        page:this.resultsPage,
                        context:null,
                        matcher:opts.matcher,
                        callback:this.bind(function(data) {
                            var def;
                            if (queryNumber == this.queryCount) {
                                if (!this.opened()) return void this.search.removeClass("select2-active");
                                if (this.context = data.context === undefined ? null :data.context, this.opts.createSearchChoice && "" !== search.val() && (def = this.opts.createSearchChoice.call(self, search.val(), data.results), 
                                def !== undefined && null !== def && self.id(def) !== undefined && null !== self.id(def) && 0 === $(data.results).filter(function() {
                                    return equal(self.id(this), self.id(def));
                                }).length && this.opts.createSearchChoicePosition(data.results, def)), 0 === data.results.length && checkFormatter(opts.formatNoMatches, "formatNoMatches")) return void render("<li class='select2-no-results'>" + opts.formatNoMatches(search.val()) + "</li>");
                                results.empty(), self.opts.populateResults.call(this, results, data.results, {
                                    term:search.val(),
                                    page:this.resultsPage,
                                    context:null
                                }), data.more === !0 && checkFormatter(opts.formatLoadMore, "formatLoadMore") && (results.append("<li class='select2-more-results'>" + self.opts.escapeMarkup(opts.formatLoadMore(this.resultsPage)) + "</li>"), 
                                window.setTimeout(function() {
                                    self.loadMoreIfNeeded();
                                }, 10)), this.postprocessResults(data, initial), postRender(), this.opts.element.trigger({
                                    type:"select2-loaded",
                                    items:data
                                });
                            }
                        })
                    });
                }
            },
            cancel:function() {
                this.close();
            },
            blur:function() {
                this.opts.selectOnBlur && this.selectHighlighted({
                    noFocus:!0
                }), this.close(), this.container.removeClass("select2-container-active"), this.search[0] === document.activeElement && this.search.blur(), 
                this.clearSearch(), this.selection.find(".select2-search-choice-focus").removeClass("select2-search-choice-focus");
            },
            focusSearch:function() {
                focus(this.search);
            },
            selectHighlighted:function(options) {
                var index = this.highlight(), highlighted = this.results.find(".select2-highlighted"), data = highlighted.closest(".select2-result").data("select2-data");
                data ? (this.highlight(index), this.onSelect(data, options)) :options && options.noFocus && this.close();
            },
            getPlaceholder:function() {
                var placeholderOption;
                return this.opts.element.attr("placeholder") || this.opts.element.attr("data-placeholder") || this.opts.element.data("placeholder") || this.opts.placeholder || ((placeholderOption = this.getPlaceholderOption()) !== undefined ? placeholderOption.text() :undefined);
            },
            getPlaceholderOption:function() {
                if (this.select) {
                    var firstOption = this.select.children("option").first();
                    if (this.opts.placeholderOption !== undefined) return "first" === this.opts.placeholderOption && firstOption || "function" == typeof this.opts.placeholderOption && this.opts.placeholderOption(this.select);
                    if ("" === firstOption.text() && "" === firstOption.val()) return firstOption;
                }
            },
            initContainerWidth:function() {
                function resolveContainerWidth() {
                    var style, attrs, matches, i, l, attr;
                    if ("off" === this.opts.width) return null;
                    if ("element" === this.opts.width) return 0 === this.opts.element.outerWidth(!1) ? "auto" :this.opts.element.outerWidth(!1) + "px";
                    if ("copy" === this.opts.width || "resolve" === this.opts.width) {
                        if (style = this.opts.element.attr("style"), style !== undefined) for (attrs = style.split(";"), 
                        i = 0, l = attrs.length; l > i; i += 1) if (attr = attrs[i].replace(/\s/g, ""), 
                        matches = attr.match(/^width:(([-+]?([0-9]*\.)?[0-9]+)(px|em|ex|%|in|cm|mm|pt|pc))/i), 
                        null !== matches && matches.length >= 1) return matches[1];
                        return "resolve" === this.opts.width ? (style = this.opts.element.css("width"), 
                        style.indexOf("%") > 0 ? style :0 === this.opts.element.outerWidth(!1) ? "auto" :this.opts.element.outerWidth(!1) + "px") :null;
                    }
                    return $.isFunction(this.opts.width) ? this.opts.width() :this.opts.width;
                }
                var width = resolveContainerWidth.call(this);
                null !== width && this.container.css("width", width);
            }
        }), SingleSelect2 = clazz(AbstractSelect2, {
            createContainer:function() {
                var container = $(document.createElement("div")).attr({
                    "class":"select2-container"
                }).html([ "<a href='javascript:void(0)' onclick='return false;' class='select2-choice' tabindex='-1'>", "   <span class='select2-chosen'>&nbsp;</span><abbr class='select2-search-choice-close'></abbr>", "   <span class='select2-arrow' role='presentation'><b role='presentation'></b></span>", "</a>", "<label for='' class='select2-offscreen'></label>", "<input class='select2-focusser select2-offscreen' type='text' aria-haspopup='true' role='button' />", "<div class='select2-drop select2-display-none'>", "   <div class='select2-search'>", "       <label for='' class='select2-offscreen'></label>", "       <input type='text' autocomplete='off' autocorrect='off' autocapitalize='off' spellcheck='false' class='select2-input' role='combobox' aria-expanded='true'", "       aria-autocomplete='list' />", "   </div>", "   <ul class='select2-results' role='listbox'>", "   </ul>", "</div>" ].join(""));
                return container;
            },
            enableInterface:function() {
                this.parent.enableInterface.apply(this, arguments) && this.focusser.prop("disabled", !this.isInterfaceEnabled());
            },
            opening:function() {
                var el, range, len;
                this.opts.minimumResultsForSearch >= 0 && this.showSearch(!0), this.parent.opening.apply(this, arguments), 
                this.showSearchInput !== !1 && this.search.val(this.focusser.val()), this.search.focus(), 
                el = this.search.get(0), el.createTextRange ? (range = el.createTextRange(), range.collapse(!1), 
                range.select()) :el.setSelectionRange && (len = this.search.val().length, el.setSelectionRange(len, len)), 
                "" === this.search.val() && this.nextSearchTerm != undefined && (this.search.val(this.nextSearchTerm), 
                this.search.select()), this.focusser.prop("disabled", !0).val(""), this.updateResults(!0), 
                this.opts.element.trigger($.Event("select2-open"));
            },
            close:function(params) {
                this.opened() && (this.parent.close.apply(this, arguments), params = params || {
                    focus:!0
                }, this.focusser.prop("disabled", !1), params.focus && this.focusser.focus());
            },
            focus:function() {
                this.opened() ? this.close() :(this.focusser.prop("disabled", !1), this.focusser.focus());
            },
            isFocused:function() {
                return this.container.hasClass("select2-container-active");
            },
            cancel:function() {
                this.parent.cancel.apply(this, arguments), this.focusser.prop("disabled", !1), this.focusser.focus();
            },
            destroy:function() {
                $("label[for='" + this.focusser.attr("id") + "']").attr("for", this.opts.element.attr("id")), 
                this.parent.destroy.apply(this, arguments);
            },
            initContainer:function() {
                var selection, elementLabel, container = this.container, dropdown = this.dropdown, idSuffix = nextUid();
                this.showSearch(this.opts.minimumResultsForSearch < 0 ? !1 :!0), this.selection = selection = container.find(".select2-choice"), 
                this.focusser = container.find(".select2-focusser"), selection.find(".select2-chosen").attr("id", "select2-chosen-" + idSuffix), 
                this.focusser.attr("aria-labelledby", "select2-chosen-" + idSuffix), this.results.attr("id", "select2-results-" + idSuffix), 
                this.search.attr("aria-owns", "select2-results-" + idSuffix), this.focusser.attr("id", "s2id_autogen" + idSuffix), 
                elementLabel = $("label[for='" + this.opts.element.attr("id") + "']"), this.focusser.prev().text(elementLabel.text()).attr("for", this.focusser.attr("id"));
                var originalTitle = this.opts.element.attr("title");
                this.opts.element.attr("title", originalTitle || elementLabel.text()), this.focusser.attr("tabindex", this.elementTabIndex), 
                this.search.attr("id", this.focusser.attr("id") + "_search"), this.search.prev().text($("label[for='" + this.focusser.attr("id") + "']").text()).attr("for", this.search.attr("id")), 
                this.search.on("keydown", this.bind(function(e) {
                    if (this.isInterfaceEnabled()) {
                        if (e.which === KEY.PAGE_UP || e.which === KEY.PAGE_DOWN) return void killEvent(e);
                        switch (e.which) {
                          case KEY.UP:
                          case KEY.DOWN:
                            return this.moveHighlight(e.which === KEY.UP ? -1 :1), void killEvent(e);

                          case KEY.ENTER:
                            return this.selectHighlighted(), void killEvent(e);

                          case KEY.TAB:
                            return void this.selectHighlighted({
                                noFocus:!0
                            });

                          case KEY.ESC:
                            return this.cancel(e), void killEvent(e);
                        }
                    }
                })), this.search.on("blur", this.bind(function() {
                    document.activeElement === this.body().get(0) && window.setTimeout(this.bind(function() {
                        this.opened() && this.search.focus();
                    }), 0);
                })), this.focusser.on("keydown", this.bind(function(e) {
                    if (this.isInterfaceEnabled() && e.which !== KEY.TAB && !KEY.isControl(e) && !KEY.isFunctionKey(e) && e.which !== KEY.ESC) {
                        if (this.opts.openOnEnter === !1 && e.which === KEY.ENTER) return void killEvent(e);
                        if (e.which == KEY.DOWN || e.which == KEY.UP || e.which == KEY.ENTER && this.opts.openOnEnter) {
                            if (e.altKey || e.ctrlKey || e.shiftKey || e.metaKey) return;
                            return this.open(), void killEvent(e);
                        }
                        return e.which == KEY.DELETE || e.which == KEY.BACKSPACE ? (this.opts.allowClear && this.clear(), 
                        void killEvent(e)) :void 0;
                    }
                })), installKeyUpChangeEvent(this.focusser), this.focusser.on("keyup-change input", this.bind(function(e) {
                    if (this.opts.minimumResultsForSearch >= 0) {
                        if (e.stopPropagation(), this.opened()) return;
                        this.open();
                    }
                })), selection.on("mousedown touchstart", "abbr", this.bind(function(e) {
                    this.isInterfaceEnabled() && (this.clear(), killEventImmediately(e), this.close(), 
                    this.selection.focus());
                })), selection.on("mousedown touchstart", this.bind(function(e) {
                    reinsertElement(selection), this.container.hasClass("select2-container-active") || this.opts.element.trigger($.Event("select2-focus")), 
                    this.opened() ? this.close() :this.isInterfaceEnabled() && this.open(), killEvent(e);
                })), dropdown.on("mousedown touchstart", this.bind(function() {
                    this.search.focus();
                })), selection.on("focus", this.bind(function(e) {
                    killEvent(e);
                })), this.focusser.on("focus", this.bind(function() {
                    this.container.hasClass("select2-container-active") || this.opts.element.trigger($.Event("select2-focus")), 
                    this.container.addClass("select2-container-active");
                })).on("blur", this.bind(function() {
                    this.opened() || (this.container.removeClass("select2-container-active"), this.opts.element.trigger($.Event("select2-blur")));
                })), this.search.on("focus", this.bind(function() {
                    this.container.hasClass("select2-container-active") || this.opts.element.trigger($.Event("select2-focus")), 
                    this.container.addClass("select2-container-active");
                })), this.initContainerWidth(), this.opts.element.addClass("select2-offscreen"), 
                this.setPlaceholder();
            },
            clear:function(triggerChange) {
                var data = this.selection.data("select2-data");
                if (data) {
                    var evt = $.Event("select2-clearing");
                    if (this.opts.element.trigger(evt), evt.isDefaultPrevented()) return;
                    var placeholderOption = this.getPlaceholderOption();
                    this.opts.element.val(placeholderOption ? placeholderOption.val() :""), this.selection.find(".select2-chosen").empty(), 
                    this.selection.removeData("select2-data"), this.setPlaceholder(), triggerChange !== !1 && (this.opts.element.trigger({
                        type:"select2-removed",
                        val:this.id(data),
                        choice:data
                    }), this.triggerChange({
                        removed:data
                    }));
                }
            },
            initSelection:function() {
                if (this.isPlaceholderOptionSelected()) this.updateSelection(null), this.close(), 
                this.setPlaceholder(); else {
                    var self = this;
                    this.opts.initSelection.call(null, this.opts.element, function(selected) {
                        selected !== undefined && null !== selected && (self.updateSelection(selected), 
                        self.close(), self.setPlaceholder(), self.nextSearchTerm = self.opts.nextSearchTerm(selected, self.search.val()));
                    });
                }
            },
            isPlaceholderOptionSelected:function() {
                var placeholderOption;
                return this.getPlaceholder() ? (placeholderOption = this.getPlaceholderOption()) !== undefined && placeholderOption.prop("selected") || "" === this.opts.element.val() || this.opts.element.val() === undefined || null === this.opts.element.val() :!1;
            },
            prepareOpts:function() {
                var opts = this.parent.prepareOpts.apply(this, arguments), self = this;
                return "select" === opts.element.get(0).tagName.toLowerCase() ? opts.initSelection = function(element, callback) {
                    var selected = element.find("option").filter(function() {
                        return this.selected;
                    });
                    callback(self.optionToData(selected));
                } :"data" in opts && (opts.initSelection = opts.initSelection || function(element, callback) {
                    var id = element.val(), match = null;
                    opts.query({
                        matcher:function(term, text, el) {
                            var is_match = equal(id, opts.id(el));
                            return is_match && (match = el), is_match;
                        },
                        callback:$.isFunction(callback) ? function() {
                            callback(match);
                        } :$.noop
                    });
                }), opts;
            },
            getPlaceholder:function() {
                return this.select && this.getPlaceholderOption() === undefined ? undefined :this.parent.getPlaceholder.apply(this, arguments);
            },
            setPlaceholder:function() {
                var placeholder = this.getPlaceholder();
                if (this.isPlaceholderOptionSelected() && placeholder !== undefined) {
                    if (this.select && this.getPlaceholderOption() === undefined) return;
                    this.selection.find(".select2-chosen").html(this.opts.escapeMarkup(placeholder)), 
                    this.selection.addClass("select2-default"), this.container.removeClass("select2-allowclear");
                }
            },
            postprocessResults:function(data, initial, noHighlightUpdate) {
                var selected = 0, selectedElm = null, self = this;
                if (this.findHighlightableChoices().each2(function(i, elm) {
                    return equal(self.id(elm.data("select2-data")), self.opts.element.val()) ? (selected = i, 
                    selectedElm = elm, !1) :void 0;
                }), noHighlightUpdate !== !1 && (initial === !0 && selected >= 0 ? null !== selectedElm ? this.opts.hideSelectionFromResult(selectedElm) && selectedElm.addClass("select2-selected") :this.highlight(selected) :this.highlight(0)), 
                initial === !0) {
                    var min = this.opts.minimumResultsForSearch;
                    min >= 0 && this.showSearch(countResults(data.results) >= min);
                }
            },
            showSearch:function(showSearchInput) {
                this.showSearchInput !== showSearchInput && (this.showSearchInput = showSearchInput, 
                this.dropdown.find(".select2-search").toggleClass("select2-search-hidden", !showSearchInput), 
                this.dropdown.find(".select2-search").toggleClass("select2-offscreen", !showSearchInput), 
                $(this.dropdown, this.container).toggleClass("select2-with-searchbox", showSearchInput));
            },
            onSelect:function(data, options) {
                if (this.triggerSelect(data)) {
                    var old = this.opts.element.val(), oldData = this.data();
                    this.opts.element.val(this.id(data)), this.updateSelection(data), this.opts.element.trigger({
                        type:"select2-selected",
                        val:this.id(data),
                        choice:data
                    }), this.nextSearchTerm = this.opts.nextSearchTerm(data, this.search.val()), this.close(), 
                    options && options.noFocus || this.focusser.focus(), equal(old, this.id(data)) || this.triggerChange({
                        added:data,
                        removed:oldData
                    });
                }
            },
            updateSelection:function(data) {
                var formatted, cssClass, container = this.selection.find(".select2-chosen");
                this.selection.data("select2-data", data), container.empty(), null !== data && (formatted = this.opts.formatSelection(data, container, this.opts.escapeMarkup)), 
                formatted !== undefined && container.append(formatted), cssClass = this.opts.formatSelectionCssClass(data, container), 
                cssClass !== undefined && container.addClass(cssClass), this.selection.removeClass("select2-default"), 
                this.opts.allowClear && this.getPlaceholder() !== undefined && this.container.addClass("select2-allowclear");
            },
            val:function() {
                var val, triggerChange = !1, data = null, self = this, oldData = this.data();
                if (0 === arguments.length) return this.opts.element.val();
                if (val = arguments[0], arguments.length > 1 && (triggerChange = arguments[1]), 
                this.select) this.select.val(val).find("option").filter(function() {
                    return this.selected;
                }).each2(function(i, elm) {
                    return data = self.optionToData(elm), !1;
                }), this.updateSelection(data), this.setPlaceholder(), triggerChange && this.triggerChange({
                    added:data,
                    removed:oldData
                }); else {
                    if (!val && 0 !== val) return void this.clear(triggerChange);
                    if (this.opts.initSelection === undefined) throw new Error("cannot call val() if initSelection() is not defined");
                    this.opts.element.val(val), this.opts.initSelection(this.opts.element, function(data) {
                        self.opts.element.val(data ? self.id(data) :""), self.updateSelection(data), self.setPlaceholder(), 
                        triggerChange && self.triggerChange({
                            added:data,
                            removed:oldData
                        });
                    });
                }
            },
            clearSearch:function() {
                this.search.val(""), this.focusser.val("");
            },
            data:function(value) {
                var data, triggerChange = !1;
                return 0 === arguments.length ? (data = this.selection.data("select2-data"), data == undefined && (data = null), 
                data) :(arguments.length > 1 && (triggerChange = arguments[1]), void (value ? (data = this.data(), 
                this.opts.element.val(value ? this.id(value) :""), this.updateSelection(value), 
                triggerChange && this.triggerChange({
                    added:value,
                    removed:data
                })) :this.clear(triggerChange)));
            }
        }), MultiSelect2 = clazz(AbstractSelect2, {
            createContainer:function() {
                var container = $(document.createElement("div")).attr({
                    "class":"select2-container select2-container-multi"
                }).html([ "<ul class='select2-choices'>", "  <li class='select2-search-field'>", "    <label for='' class='select2-offscreen'></label>", "    <input type='text' autocomplete='off' autocorrect='off' autocapitalize='off' spellcheck='false' class='select2-input'>", "  </li>", "</ul>", "<div class='select2-drop select2-drop-multi select2-display-none'>", "   <ul class='select2-results'>", "   </ul>", "</div>" ].join(""));
                return container;
            },
            prepareOpts:function() {
                var opts = this.parent.prepareOpts.apply(this, arguments), self = this;
                return "select" === opts.element.get(0).tagName.toLowerCase() ? opts.initSelection = function(element, callback) {
                    var data = [];
                    element.find("option").filter(function() {
                        return this.selected;
                    }).each2(function(i, elm) {
                        data.push(self.optionToData(elm));
                    }), callback(data);
                } :"data" in opts && (opts.initSelection = opts.initSelection || function(element, callback) {
                    var ids = splitVal(element.val(), opts.separator), matches = [];
                    opts.query({
                        matcher:function(term, text, el) {
                            var is_match = $.grep(ids, function(id) {
                                return equal(id, opts.id(el));
                            }).length;
                            return is_match && matches.push(el), is_match;
                        },
                        callback:$.isFunction(callback) ? function() {
                            for (var ordered = [], i = 0; i < ids.length; i++) for (var id = ids[i], j = 0; j < matches.length; j++) {
                                var match = matches[j];
                                if (equal(id, opts.id(match))) {
                                    ordered.push(match), matches.splice(j, 1);
                                    break;
                                }
                            }
                            callback(ordered);
                        } :$.noop
                    });
                }), opts;
            },
            selectChoice:function(choice) {
                var selected = this.container.find(".select2-search-choice-focus");
                selected.length && choice && choice[0] == selected[0] || (selected.length && this.opts.element.trigger("choice-deselected", selected), 
                selected.removeClass("select2-search-choice-focus"), choice && choice.length && (this.close(), 
                choice.addClass("select2-search-choice-focus"), this.opts.element.trigger("choice-selected", choice)));
            },
            destroy:function() {
                $("label[for='" + this.search.attr("id") + "']").attr("for", this.opts.element.attr("id")), 
                this.parent.destroy.apply(this, arguments);
            },
            initContainer:function() {
                var selection, selector = ".select2-choices";
                this.searchContainer = this.container.find(".select2-search-field"), this.selection = selection = this.container.find(selector);
                var _this = this;
                this.selection.on("click", ".select2-search-choice:not(.select2-locked)", function() {
                    _this.search[0].focus(), _this.selectChoice($(this));
                }), this.search.attr("id", "s2id_autogen" + nextUid()), this.search.prev().text($("label[for='" + this.opts.element.attr("id") + "']").text()).attr("for", this.search.attr("id")), 
                this.search.on("input paste", this.bind(function() {
                    this.isInterfaceEnabled() && (this.opened() || this.open());
                })), this.search.attr("tabindex", this.elementTabIndex), this.keydowns = 0, this.search.on("keydown", this.bind(function(e) {
                    if (this.isInterfaceEnabled()) {
                        ++this.keydowns;
                        var selected = selection.find(".select2-search-choice-focus"), prev = selected.prev(".select2-search-choice:not(.select2-locked)"), next = selected.next(".select2-search-choice:not(.select2-locked)"), pos = getCursorInfo(this.search);
                        if (selected.length && (e.which == KEY.LEFT || e.which == KEY.RIGHT || e.which == KEY.BACKSPACE || e.which == KEY.DELETE || e.which == KEY.ENTER)) {
                            var selectedChoice = selected;
                            return e.which == KEY.LEFT && prev.length ? selectedChoice = prev :e.which == KEY.RIGHT ? selectedChoice = next.length ? next :null :e.which === KEY.BACKSPACE ? (this.unselect(selected.first()), 
                            this.search.width(10), selectedChoice = prev.length ? prev :next) :e.which == KEY.DELETE ? (this.unselect(selected.first()), 
                            this.search.width(10), selectedChoice = next.length ? next :null) :e.which == KEY.ENTER && (selectedChoice = null), 
                            this.selectChoice(selectedChoice), killEvent(e), void (selectedChoice && selectedChoice.length || this.open());
                        }
                        if ((e.which === KEY.BACKSPACE && 1 == this.keydowns || e.which == KEY.LEFT) && 0 == pos.offset && !pos.length) return this.selectChoice(selection.find(".select2-search-choice:not(.select2-locked)").last()), 
                        void killEvent(e);
                        if (this.selectChoice(null), this.opened()) switch (e.which) {
                          case KEY.UP:
                          case KEY.DOWN:
                            return this.moveHighlight(e.which === KEY.UP ? -1 :1), void killEvent(e);

                          case KEY.ENTER:
                            return this.selectHighlighted(), void killEvent(e);

                          case KEY.TAB:
                            return this.selectHighlighted({
                                noFocus:!0
                            }), void this.close();

                          case KEY.ESC:
                            return this.cancel(e), void killEvent(e);
                        }
                        if (e.which !== KEY.TAB && !KEY.isControl(e) && !KEY.isFunctionKey(e) && e.which !== KEY.BACKSPACE && e.which !== KEY.ESC) {
                            if (e.which === KEY.ENTER) {
                                if (this.opts.openOnEnter === !1) return;
                                if (e.altKey || e.ctrlKey || e.shiftKey || e.metaKey) return;
                            }
                            this.open(), (e.which === KEY.PAGE_UP || e.which === KEY.PAGE_DOWN) && killEvent(e), 
                            e.which === KEY.ENTER && killEvent(e);
                        }
                    }
                })), this.search.on("keyup", this.bind(function() {
                    this.keydowns = 0, this.resizeSearch();
                })), this.search.on("blur", this.bind(function(e) {
                    this.container.removeClass("select2-container-active"), this.search.removeClass("select2-focused"), 
                    this.selectChoice(null), this.opened() || this.clearSearch(), e.stopImmediatePropagation(), 
                    this.opts.element.trigger($.Event("select2-blur"));
                })), this.container.on("click", selector, this.bind(function(e) {
                    this.isInterfaceEnabled() && ($(e.target).closest(".select2-search-choice").length > 0 || (this.selectChoice(null), 
                    this.clearPlaceholder(), this.container.hasClass("select2-container-active") || this.opts.element.trigger($.Event("select2-focus")), 
                    this.open(), this.focusSearch(), e.preventDefault()));
                })), this.container.on("focus", selector, this.bind(function() {
                    this.isInterfaceEnabled() && (this.container.hasClass("select2-container-active") || this.opts.element.trigger($.Event("select2-focus")), 
                    this.container.addClass("select2-container-active"), this.dropdown.addClass("select2-drop-active"), 
                    this.clearPlaceholder());
                })), this.initContainerWidth(), this.opts.element.addClass("select2-offscreen"), 
                this.clearSearch();
            },
            enableInterface:function() {
                this.parent.enableInterface.apply(this, arguments) && this.search.prop("disabled", !this.isInterfaceEnabled());
            },
            initSelection:function() {
                if ("" === this.opts.element.val() && "" === this.opts.element.text() && (this.updateSelection([]), 
                this.close(), this.clearSearch()), this.select || "" !== this.opts.element.val()) {
                    var self = this;
                    this.opts.initSelection.call(null, this.opts.element, function(data) {
                        data !== undefined && null !== data && (self.updateSelection(data), self.close(), 
                        self.clearSearch());
                    });
                }
            },
            clearSearch:function() {
                var placeholder = this.getPlaceholder(), maxWidth = this.getMaxSearchWidth();
                placeholder !== undefined && 0 === this.getVal().length && this.search.hasClass("select2-focused") === !1 ? (this.search.val(placeholder).addClass("select2-default"), 
                this.search.width(maxWidth > 0 ? maxWidth :this.container.css("width"))) :this.search.val("").width(10);
            },
            clearPlaceholder:function() {
                this.search.hasClass("select2-default") && this.search.val("").removeClass("select2-default");
            },
            opening:function() {
                this.clearPlaceholder(), this.resizeSearch(), this.parent.opening.apply(this, arguments), 
                this.focusSearch(), "" === this.search.val() && this.nextSearchTerm != undefined && (this.search.val(this.nextSearchTerm), 
                this.search.select()), this.updateResults(!0), this.search.focus(), this.opts.element.trigger($.Event("select2-open"));
            },
            close:function() {
                this.opened() && this.parent.close.apply(this, arguments);
            },
            focus:function() {
                this.close(), this.search.focus();
            },
            isFocused:function() {
                return this.search.hasClass("select2-focused");
            },
            updateSelection:function(data) {
                var ids = [], filtered = [], self = this;
                $(data).each(function() {
                    indexOf(self.id(this), ids) < 0 && (ids.push(self.id(this)), filtered.push(this));
                }), data = filtered, this.selection.find(".select2-search-choice").remove(), $(data).each(function() {
                    self.addSelectedChoice(this);
                }), self.postprocessResults();
            },
            tokenize:function() {
                var input = this.search.val();
                input = this.opts.tokenizer.call(this, input, this.data(), this.bind(this.onSelect), this.opts), 
                null != input && input != undefined && (this.search.val(input), input.length > 0 && this.open());
            },
            onSelect:function(data, options) {
                this.triggerSelect(data) && (this.addSelectedChoice(data), this.opts.element.trigger({
                    type:"selected",
                    val:this.id(data),
                    choice:data
                }), this.nextSearchTerm = this.opts.nextSearchTerm(data, this.search.val()), this.clearSearch(), 
                this.updateResults(), (this.select || !this.opts.closeOnSelect) && this.postprocessResults(data, !1, this.opts.closeOnSelect === !0), 
                this.opts.closeOnSelect ? (this.close(), this.search.width(10)) :this.countSelectableResults() > 0 ? (this.search.width(10), 
                this.resizeSearch(), this.getMaximumSelectionSize() > 0 && this.val().length >= this.getMaximumSelectionSize() ? this.updateResults(!0) :this.nextSearchTerm != undefined && (this.search.val(this.nextSearchTerm), 
                this.updateResults(), this.search.select()), this.positionDropdown()) :(this.close(), 
                this.search.width(10)), this.triggerChange({
                    added:data
                }), options && options.noFocus || this.focusSearch());
            },
            cancel:function() {
                this.close(), this.focusSearch();
            },
            addSelectedChoice:function(data) {
                var formatted, cssClass, enableChoice = !data.locked, enabledItem = $("<li class='select2-search-choice'>    <div></div>    <a href='#' onclick='return false;' class='select2-search-choice-close' tabindex='-1'></a></li>"), disabledItem = $("<li class='select2-search-choice select2-locked'><div></div></li>"), choice = enableChoice ? enabledItem :disabledItem, id = this.id(data), val = this.getVal();
                formatted = this.opts.formatSelection(data, choice.find("div"), this.opts.escapeMarkup), 
                formatted != undefined && choice.find("div").replaceWith("<div>" + formatted + "</div>"), 
                cssClass = this.opts.formatSelectionCssClass(data, choice.find("div")), cssClass != undefined && choice.addClass(cssClass), 
                enableChoice && choice.find(".select2-search-choice-close").on("mousedown", killEvent).on("click dblclick", this.bind(function(e) {
                    this.isInterfaceEnabled() && ($(e.target).closest(".select2-search-choice").fadeOut("fast", this.bind(function() {
                        this.unselect($(e.target)), this.selection.find(".select2-search-choice-focus").removeClass("select2-search-choice-focus"), 
                        this.close(), this.focusSearch();
                    })).dequeue(), killEvent(e));
                })).on("focus", this.bind(function() {
                    this.isInterfaceEnabled() && (this.container.addClass("select2-container-active"), 
                    this.dropdown.addClass("select2-drop-active"));
                })), choice.data("select2-data", data), choice.insertBefore(this.searchContainer), 
                val.push(id), this.setVal(val);
            },
            unselect:function(selected) {
                var data, index, val = this.getVal();
                if (selected = selected.closest(".select2-search-choice"), 0 === selected.length) throw "Invalid argument: " + selected + ". Must be .select2-search-choice";
                if (data = selected.data("select2-data")) {
                    for (;(index = indexOf(this.id(data), val)) >= 0; ) val.splice(index, 1), this.setVal(val), 
                    this.select && this.postprocessResults();
                    var evt = $.Event("select2-removing");
                    evt.val = this.id(data), evt.choice = data, this.opts.element.trigger(evt), evt.isDefaultPrevented() || (selected.remove(), 
                    this.opts.element.trigger({
                        type:"select2-removed",
                        val:this.id(data),
                        choice:data
                    }), this.triggerChange({
                        removed:data
                    }));
                }
            },
            postprocessResults:function(data, initial, noHighlightUpdate) {
                var val = this.getVal(), choices = this.results.find(".select2-result"), compound = this.results.find(".select2-result-with-children"), self = this;
                choices.each2(function(i, choice) {
                    var id = self.id(choice.data("select2-data"));
                    indexOf(id, val) >= 0 && (self.opts.hideSelectionFromResult(choice) === undefined || self.opts.hideSelectionFromResult(choice)) && (choice.addClass("select2-selected"), 
                    choice.find(".select2-result-selectable").addClass("select2-selected"));
                }), compound.each2(function(i, choice) {
                    choice.is(".select2-result-selectable") || 0 !== choice.find(".select2-result-selectable:not(.select2-selected)").length || choice.addClass("select2-selected");
                }), -1 == this.highlight() && noHighlightUpdate !== !1 && self.highlight(0), !this.opts.createSearchChoice && !choices.filter(".select2-result:not(.select2-selected)").length > 0 && (!data || data && !data.more && 0 === this.results.find(".select2-no-results").length) && checkFormatter(self.opts.formatNoMatches, "formatNoMatches") && this.results.append("<li class='select2-no-results'>" + self.opts.formatNoMatches(self.search.val()) + "</li>");
            },
            getMaxSearchWidth:function() {
                return this.selection.width() - getSideBorderPadding(this.search);
            },
            resizeSearch:function() {
                var minimumWidth, left, maxWidth, containerLeft, searchWidth, sideBorderPadding = getSideBorderPadding(this.search);
                minimumWidth = measureTextWidth(this.search) + 10, left = this.search.offset().left, 
                maxWidth = this.selection.width(), containerLeft = this.selection.offset().left, 
                searchWidth = maxWidth - (left - containerLeft) - sideBorderPadding, minimumWidth > searchWidth && (searchWidth = maxWidth - sideBorderPadding), 
                40 > searchWidth && (searchWidth = maxWidth - sideBorderPadding), 0 >= searchWidth && (searchWidth = minimumWidth), 
                this.search.width(Math.floor(searchWidth));
            },
            getVal:function() {
                var val;
                return this.select ? (val = this.select.val(), null === val ? [] :val) :(val = this.opts.element.val(), 
                splitVal(val, this.opts.separator));
            },
            setVal:function(val) {
                var unique;
                this.select ? this.select.val(val) :(unique = [], $(val).each(function() {
                    indexOf(this, unique) < 0 && unique.push(this);
                }), this.opts.element.val(0 === unique.length ? "" :unique.join(this.opts.separator)));
            },
            buildChangeDetails:function(old, current) {
                for (var current = current.slice(0), old = old.slice(0), i = 0; i < current.length; i++) for (var j = 0; j < old.length; j++) equal(this.opts.id(current[i]), this.opts.id(old[j])) && (current.splice(i, 1), 
                i > 0 && i--, old.splice(j, 1), j--);
                return {
                    added:current,
                    removed:old
                };
            },
            val:function(val, triggerChange) {
                var oldData, self = this;
                if (0 === arguments.length) return this.getVal();
                if (oldData = this.data(), oldData.length || (oldData = []), !val && 0 !== val) return this.opts.element.val(""), 
                this.updateSelection([]), this.clearSearch(), void (triggerChange && this.triggerChange({
                    added:this.data(),
                    removed:oldData
                }));
                if (this.setVal(val), this.select) this.opts.initSelection(this.select, this.bind(this.updateSelection)), 
                triggerChange && this.triggerChange(this.buildChangeDetails(oldData, this.data())); else {
                    if (this.opts.initSelection === undefined) throw new Error("val() cannot be called if initSelection() is not defined");
                    this.opts.initSelection(this.opts.element, function(data) {
                        var ids = $.map(data, self.id);
                        self.setVal(ids), self.updateSelection(data), self.clearSearch(), triggerChange && self.triggerChange(self.buildChangeDetails(oldData, self.data()));
                    });
                }
                this.clearSearch();
            },
            onSortStart:function() {
                if (this.select) throw new Error("Sorting of elements is not supported when attached to <select>. Attach to <input type='hidden'/> instead.");
                this.search.width(0), this.searchContainer.hide();
            },
            onSortEnd:function() {
                var val = [], self = this;
                this.searchContainer.show(), this.searchContainer.appendTo(this.searchContainer.parent()), 
                this.resizeSearch(), this.selection.find(".select2-search-choice").each(function() {
                    val.push(self.opts.id($(this).data("select2-data")));
                }), this.setVal(val), this.triggerChange();
            },
            data:function(values, triggerChange) {
                var ids, old, self = this;
                return 0 === arguments.length ? this.selection.children(".select2-search-choice").map(function() {
                    return $(this).data("select2-data");
                }).get() :(old = this.data(), values || (values = []), ids = $.map(values, function(e) {
                    return self.opts.id(e);
                }), this.setVal(ids), this.updateSelection(values), this.clearSearch(), triggerChange && this.triggerChange(this.buildChangeDetails(old, this.data())), 
                void 0);
            }
        }), $.fn.select2 = function() {
            var opts, select2, method, value, multiple, args = Array.prototype.slice.call(arguments, 0), allowedMethods = [ "val", "destroy", "opened", "open", "close", "focus", "isFocused", "container", "dropdown", "onSortStart", "onSortEnd", "enable", "disable", "readonly", "positionDropdown", "data", "search" ], valueMethods = [ "opened", "isFocused", "container", "dropdown" ], propertyMethods = [ "val", "data" ], methodsMap = {
                search:"externalSearch"
            };
            return this.each(function() {
                if (0 === args.length || "object" == typeof args[0]) opts = 0 === args.length ? {} :$.extend({}, args[0]), 
                opts.element = $(this), "select" === opts.element.get(0).tagName.toLowerCase() ? multiple = opts.element.prop("multiple") :(multiple = opts.multiple || !1, 
                "tags" in opts && (opts.multiple = multiple = !0)), select2 = multiple ? new window.Select2["class"].multi() :new window.Select2["class"].single(), 
                select2.init(opts); else {
                    if ("string" != typeof args[0]) throw "Invalid arguments to select2 plugin: " + args;
                    if (indexOf(args[0], allowedMethods) < 0) throw "Unknown method: " + args[0];
                    if (value = undefined, select2 = $(this).data("select2"), select2 === undefined) return;
                    if (method = args[0], "container" === method ? value = select2.container :"dropdown" === method ? value = select2.dropdown :(methodsMap[method] && (method = methodsMap[method]), 
                    value = select2[method].apply(select2, args.slice(1))), indexOf(args[0], valueMethods) >= 0 || indexOf(args[0], propertyMethods) && 1 == args.length) return !1;
                }
            }), value === undefined ? this :value;
        }, $.fn.select2.defaults = {
            width:"copy",
            loadMorePadding:0,
            closeOnSelect:!0,
            openOnEnter:!0,
            containerCss:{},
            dropdownCss:{},
            containerCssClass:"",
            dropdownCssClass:"",
            formatResult:function(result, container, query, escapeMarkup) {
                var markup = [];
                return markMatch(result.text, query.term, markup, escapeMarkup), markup.join("");
            },
            formatSelection:function(data, container, escapeMarkup) {
                return data ? escapeMarkup(data.text) :undefined;
            },
            sortResults:function(results) {
                return results;
            },
            formatResultCssClass:function(data) {
                return data.css;
            },
            formatSelectionCssClass:function() {
                return undefined;
            },
            formatMatches:function(matches) {
                return matches + " results are available, use up and down arrow keys to navigate.";
            },
            formatNoMatches:function() {
                return "No matches found";
            },
            formatInputTooShort:function(input, min) {
                var n = min - input.length;
                return "Please enter " + n + " or more character" + (1 == n ? "" :"s");
            },
            formatInputTooLong:function(input, max) {
                var n = input.length - max;
                return "Please delete " + n + " character" + (1 == n ? "" :"s");
            },
            formatSelectionTooBig:function(limit) {
                return "You can only select " + limit + " item" + (1 == limit ? "" :"s");
            },
            formatLoadMore:function() {
                return "Loading more results…";
            },
            formatSearching:function() {
                return "Searching…";
            },
            minimumResultsForSearch:0,
            minimumInputLength:0,
            maximumInputLength:null,
            maximumSelectionSize:0,
            id:function(e) {
                return e == undefined ? null :e.id;
            },
            matcher:function(term, text) {
                return stripDiacritics("" + text).toUpperCase().indexOf(stripDiacritics("" + term).toUpperCase()) >= 0;
            },
            separator:",",
            tokenSeparators:[],
            tokenizer:defaultTokenizer,
            escapeMarkup:defaultEscapeMarkup,
            blurOnChange:!1,
            selectOnBlur:!1,
            adaptContainerCssClass:function(c) {
                return c;
            },
            adaptDropdownCssClass:function() {
                return null;
            },
            nextSearchTerm:function() {
                return undefined;
            },
            hideSelectionFromResult:function() {
                return undefined;
            },
            searchInputPlaceholder:"",
            createSearchChoicePosition:"top"
        }, $.fn.select2.ajaxDefaults = {
            transport:$.ajax,
            params:{
                type:"GET",
                cache:!1,
                dataType:"json"
            }
        }, window.Select2 = {
            query:{
                ajax:ajax,
                local:local,
                tags:tags
            },
            util:{
                debounce:debounce,
                markMatch:markMatch,
                escapeMarkup:defaultEscapeMarkup,
                stripDiacritics:stripDiacritics
            },
            "class":{
                "abstract":AbstractSelect2,
                single:SingleSelect2,
                multi:MultiSelect2
            }
        };
    }
}(jQuery), function() {
    var format_result, format_selection;
    window.Application || (window.Application = {}), format_result = function(data) {
        return null != data["new"] ? "Создать: " + data.text.toString().toUpperCase() :data.text;
    }, format_selection = function(data) {
        return data.text.toString().toUpperCase();
    }, $(function() {
        return Application.initSelect2();
    }), $(document).on("page:load", function() {
        return Application.initSelect2();
    }), Application.initSelect2 = function() {
        var brand, generation, model, modification;
        return brand = void 0, $("input[rel='select2-brand']").each(function(idx, el) {
            return brand = el;
        }), model = void 0, $("input[rel='select2-model']").each(function(idx, el) {
            return model = el;
        }), generation = void 0, $("input[rel='select2-generation']").each(function(idx, el) {
            return generation = el;
        }), modification = void 0, $("input[rel='select2-modification']").each(function(idx, el) {
            return modification = el;
        }), $(brand).select2({
            allowClear:!0,
            initSelection:function(element, callback) {
                var data;
                return data = {
                    id:$(element).val(),
                    true_id:$(element).data("true-id"),
                    text:$(element).val()
                }, callback(data);
            },
            formatResult:format_result,
            formatSelection:format_selection,
            query:function(options) {
                var params, zzz;
                return params = {
                    page:options.page,
                    name:options.term
                }, zzz = void 0, zzz = {
                    results:[]
                }, null == options.context && options.page <= 1 && null != options.term && options.term.length > 0 && zzz.results.push({
                    id:options.term,
                    text:options.term,
                    "new":!0
                }), $.getJSON("/brands/search/?" + $.param(params), function(data) {
                    return data.map(function(data) {
                        return zzz.results.push({
                            id:data.name,
                            true_id:data.id,
                            text:data.name
                        });
                    }), data.length && (zzz.more = !0), options.callback(zzz);
                });
            }
        }), $(brand).on("change", function() {
            return $(model).select2("val", ""), $(generation).select2("val", ""), $(modification).select2("val", "");
        }), $(model).select2({
            allowClear:!0,
            initSelection:function(element, callback) {
                var data;
                return data = {
                    id:$(element).val(),
                    true_id:$(element).data("true-id"),
                    text:$(element).val()
                }, callback(data);
            },
            formatResult:format_result,
            formatSelection:format_selection,
            query:function(options) {
                var params, zzz;
                return params = {
                    page:options.page,
                    name:options.term,
                    brand_id:-1
                }, $(brand).length > 0 && null != $(brand).select2("data") && null != $(brand).select2("data").true_id && (params.brand_id = $(brand).select2("data").true_id), 
                zzz = void 0, zzz = {
                    results:[]
                }, null == options.context && options.page <= 1 && null != options.term && options.term.length > 0 && zzz.results.push({
                    id:options.term,
                    text:options.term,
                    "new":!0
                }), $.getJSON("/models/search/?" + $.param(params), function(data) {
                    return data.map(function(data) {
                        return zzz.results.push({
                            id:data.name,
                            true_id:data.id,
                            text:data.name
                        });
                    }), data.length && (zzz.more = !0), options.callback(zzz);
                });
            }
        }), $(model).on("change", function() {
            return $(generation).select2("val", ""), $(modification).select2("val", "");
        }), $(generation).select2({
            allowClear:!0,
            initSelection:function(element, callback) {
                var data;
                return data = {
                    id:$(element).val(),
                    true_id:$(element).data("true-id"),
                    text:$(element).val()
                }, callback(data);
            },
            formatResult:format_result,
            formatSelection:format_selection,
            query:function(options) {
                var params, zzz;
                return params = {
                    page:options.page,
                    name:options.term,
                    model_id:-1
                }, $(model).length > 0 && $(model).select2("data") && null != $(model).select2("data").true_id && (params.model_id = $(model).select2("data").true_id), 
                zzz = void 0, zzz = {
                    results:[]
                }, null == options.context && options.page <= 1 && null != options.term && options.term.length > 0 && zzz.results.push({
                    id:options.term,
                    text:options.term,
                    "new":!0
                }), $.getJSON("/generations/search/?" + $.param(params), function(data) {
                    return data.map(function(data) {
                        return zzz.results.push({
                            id:data.name,
                            true_id:data.id,
                            text:data.name
                        });
                    }), data.length && (zzz.more = !0), options.callback(zzz);
                });
            }
        }), $(generation).on("change", function() {
            return $(modification).select2("val", "");
        }), $(modification).select2({
            allowClear:!0,
            initSelection:function(element, callback) {
                var data;
                return data = {
                    id:$(element).val(),
                    true_id:$(element).data("true-id"),
                    text:$(element).val()
                }, callback(data);
            },
            formatResult:format_result,
            formatSelection:format_selection,
            query:function(options) {
                var params, zzz;
                return params = {
                    page:options.page,
                    name:options.term,
                    generation_id:-1
                }, $(generation).length > 0 && null != $(generation).select2("data") && null != $(generation).select2("data").true_id && (params.generation_id = $(generation).select2("data").true_id), 
                zzz = void 0, zzz = {
                    results:[]
                }, null == options.context && options.page <= 1 && null != options.term && options.term.length > 0 && zzz.results.push({
                    id:options.term,
                    text:options.term,
                    "new":!0
                }), $.getJSON("/modifications/search/?" + $.param(params), function(data) {
                    return data.map(function(data) {
                        return zzz.results.push({
                            id:data.name,
                            true_id:data.id,
                            text:data.name
                        });
                    }), data.length && (zzz.more = !0), options.callback(zzz);
                });
            }
        });
    };
}.call(this), Player.prototype.play = function(song) {
    this.currentlyPlayingSong = song, this.isPlaying = !0;
}, Player.prototype.pause = function() {
    this.isPlaying = !1;
}, Player.prototype.resume = function() {
    if (this.isPlaying) throw new Error("song is already playing");
    this.isPlaying = !0;
}, Player.prototype.makeFavorite = function() {
    this.currentlyPlayingSong.persistFavoriteStatus(!0);
}, Song.prototype.persistFavoriteStatus = function() {
    throw new Error("not yet implemented");
}, function() {
    $(document).on("custom-change", "[rel~='radio-use-auto-russian-time-zone']", function() {
        return $(this).prop("checked") ? "true" === $(this).val() ? ($("#user_russian_time_zone_manual_id").parent().hide(), 
        $("#user_cached_russian_time_zone_auto_id").parent().show()) :($("#user_russian_time_zone_manual_id").parent().show(), 
        $("#user_cached_russian_time_zone_auto_id").parent().hide()) :void 0;
    });
}.call(this), function() {
    $(document).on("custom-change", "[rel~='radio-vin-or-frame']", function() {
        return $(this).prop("checked") ? "frame" === $(this).val() ? ($("#car_vin").parent().hide(), 
        $("#car_frame").parent().show()) :($("#car_vin").parent().show(), $("#car_frame").parent().hide()) :void 0;
    });
}.call(this), function() {
    $(document).on("click", ".buy-button", function(event) {
        return event.preventDefault(), $("#product_catalog_number").val($(this).data("catalog-number")), 
        $("#product_sell_cost").val($(this).data("cost")), $("#product_quantity_available").val($(this).data("count")), 
        $("#product_min_days").val($(this).data("min-days")), $("#product_max_days").val($(this).data("max-days")), 
        $("#product_probability").val($(this).data("probability")), $("#s2id_product_brand_attributes_name").select2("val", $(this).data("manufacturer")), 
        $("#product_brand_attributes_name").val($(this).data("manufacturer")), $("#product_buy_cost").val($(this).data("income-cost")), 
        $("#product_short_name").val($(this).data("short-name")), $("#product_long_name").val($(this).data("long-name")), 
        $("#modal_form").modal("show");
    });
}.call(this), function() {
    $(function() {
        var url;
        return url = $.url(), url.param("modal") ? $("#modal_form").modal("show") :void 0;
    });
}.call(this), function() {
    var update;
    $(document).on("click", "#check-items", function(e) {
        return e.preventDefault(), $("input.item[type=checkbox]").prop("checked", !0), update();
    }), $(document).on("click", "#uncheck-items", function(e) {
        return e.preventDefault(), $("input.item[type=checkbox]").prop("checked", !1), update();
    }), $(document).on("change", "input.item[type=checkbox]", function() {
        return update();
    }), update = function() {
        var form, items;
        return form = $("#new_grid"), items = $("#grid-toolbar-selected"), $("<input>").attr({
            type:"hidden",
            name:"items",
            value:""
        }).appendTo(items), form.trigger("submit.rails");
    }, $(document).on("submit", "#new_grid", function() {
        return $(".modal").modal("hide");
    });
}.call(this), jQuery.cachedScript = function(url, options) {
    return options = $.extend(options || {}, {
        dataType:"script",
        cache:!0,
        url:url
    }), jQuery.ajax(options);
}, CKEDITOR_BASEPATH = "/new_assets/ckeditor/", function() {
    var root;
    root = "undefined" != typeof exports && null !== exports ? exports :window, window.extended_options = {
        allowedContent:!0,
        height:400,
        extraPlugins:"timestamp,abbr,divarea,codemirror,oembed,image2,upload",
        plugins:"about,a11yhelp,basicstyles,bidi,blockquote,clipboard,colorbutton,colordialog,contextmenu,div,elementspath,enterkey,entities,filebrowser,find,flash,floatingspace,font,format,horizontalrule,htmlwriter,indent,justify,link,list,liststyle,magicline,maximize,newpage,pagebreak,pastefromword,pastetext,preview,print,removeformat,resize,save,selectall,showblocks,showborders,smiley,sourcearea,specialchar,stylescombo,tab,table,tabletools,templates,toolbar,undo,wysiwygarea",
        removePlugins:"image,forms",
        toolbarGroups:[ {
            name:"document",
            groups:[ "mode", "document", "doctools" ]
        }, {
            name:"clipboard",
            groups:[ "clipboard", "undo" ]
        }, {
            name:"editing",
            groups:[ "find", "selection", "spellchecker" ]
        }, {
            name:"forms"
        }, "/", {
            name:"basicstyles",
            groups:[ "basicstyles", "cleanup" ]
        }, {
            name:"paragraph",
            groups:[ "list", "indent", "blocks", "align" ]
        }, {
            name:"links"
        }, {
            name:"insert"
        }, "/", {
            name:"styles"
        }, {
            name:"colors"
        }, {
            name:"tools"
        }, {
            name:"others"
        }, {
            name:"about"
        }, {
            name:"oembed"
        } ],
        filebrowserBrowseUrl:"/browser/browse/type/all",
        filebrowserImageBrowseUrl:"/admin/uploads",
        filebrowserWindowWidth:700,
        filebrowserWindowHeight:350
    };
}.call(this), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, $(document).on("update-ckeditor-extended", function() {
        return App.initExtendedCkeditor();
    }), $(document).on("page:load", function() {
        return $(document).trigger("update-ckeditor-extended");
    }), $(function() {
        return $(document).trigger("update-ckeditor-extended");
    }), window.initExtendedCkeditor = function() {
        var placeholders, url;
        return placeholders = $(".ckeditor-extended"), placeholders.length > 0 ? ($(placeholders).removeClass("ckeditor-extended").addClass("ckeditor-extended-initialized"), 
        url = "/new_assets/ckeditor/ckeditor.js", $.cachedScript(url).done(function() {
            var ckeditor, dirtyforms, i, root, tmp_ckeditor, _i, _len, _results;
            for (CKEDITOR.plugins.addExternal("upload", "/new_assets/upload/", "plugin.js"), 
            CKEDITOR.plugins.addExternal("oembed", "/new_assets/oembed/", "plugin.js"), CKEDITOR.plugins.addExternal("codemirror", "/new_assets/codemirror/codemirror/", "plugin.js"), 
            CKEDITOR.plugins.addExternal("timestamp", "/new_assets/timestamp/", "plugin.js"), 
            CKEDITOR.plugins.addExternal("abbr", "/new_assets/abbr/", "plugin.js"), _results = [], 
            i = _i = 0, _len = placeholders.length; _len > _i; i = ++_i) ckeditor = placeholders[i], 
            tmp_ckeditor = CKEDITOR.replace(ckeditor, window.extended_options), root = "undefined" != typeof exports && null !== exports ? exports :window, 
            null != root && null != root.DirtyForms ? (dirtyforms = new root.DirtyForms.get(), 
            _results.push(dirtyforms.lazy_added_ckeditor(tmp_ckeditor))) :_results.push(void 0);
            return _results;
        })) :void 0;
    };
}.call(this), function() {
    var root;
    root = "undefined" != typeof exports && null !== exports ? exports :window, window.simple_options = function() {
        return {
            plugins:"basicstyles,list,link,pastetext,toolbar,undo,save",
            toolbar:[ {
                name:"basicstyles",
                items:[ "Bold", "Italic" ]
            }, {
                name:"links",
                items:[ "Link", "Unlink" ]
            }, {
                name:"paragraph",
                groups:[ "list" ],
                items:[ "NumberedList" ]
            }, [ "Upload" ] ],
            forcePasteAsPlainText:!0,
            height:"auto",
            extraPlugins:"divarea,autogrow,upload",
            removePlugins:"resize",
            keystrokes:[ [ CKEDITOR.CTRL + 13, "save" ] ]
        };
    };
}.call(this), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, $(document).on("update-ckeditor-simple", function() {
        return App.initSimpleCkeditor();
    }), $(document).on("page:load", function() {
        return $(document).trigger("update-ckeditor-simple");
    }), $(function() {
        return $(document).trigger("update-ckeditor-simple");
    }), App.initSimpleCkeditor = function() {
        var placeholders, url;
        return placeholders = $(".ckeditor-simple"), placeholders.length > 0 ? ($(placeholders).removeClass("ckeditor-simple").addClass("ckeditor-simple-initialized"), 
        url = "/new_assets/ckeditor/ckeditor.js", $.cachedScript(url).done(function() {
            var ckeditor, dirtyforms, i, root, tmp_ckeditor, _i, _len, _results;
            for (CKEDITOR.plugins.addExternal("upload", "/new_assets/upload/", "plugin.js"), 
            _results = [], i = _i = 0, _len = placeholders.length; _len > _i; i = ++_i) ckeditor = placeholders[i], 
            tmp_ckeditor = CKEDITOR.replace(ckeditor, window.simple_options()), tmp_ckeditor.on("instanceReady", function(ev) {
                var overridecmd;
                return overridecmd = new CKEDITOR.command(ev.editor, {
                    exec:function(editor) {
                        return $(editor.element.$.form).find("[type=submit]").trigger("click");
                    }
                }), ev.editor.commands.save.exec = overridecmd.exec;
            }), root = "undefined" != typeof exports && null !== exports ? exports :window, 
            null != root && null != root.DirtyForms ? (dirtyforms = new root.DirtyForms.get(), 
            _results.push(dirtyforms.lazy_added_ckeditor(tmp_ckeditor))) :_results.push(void 0);
            return _results;
        })) :void 0;
    };
}.call(this), function() {
    window.initMap = function() {
        var add_events_handler_to_shape, clearSelection, initialize, selectedShape, setSelection, update_vertices;
        return $(document).on("click", "#geocode-address-button", function() {
            return window.geocoder = new google.maps.Geocoder(), window.codeAddress($("#geocode-address-text").val());
        }), window.codeAddress = function(address) {
            return window.geocoder.geocode({
                address:address
            }, function(results, status) {
                var marker;
                return status === google.maps.GeocoderStatus.OK ? (window.map.setCenter(results[0].geometry.location), 
                marker = new google.maps.Marker({
                    map:window.map,
                    position:results[0].geometry.location
                })) :console.log("Не удалось определить местоположение, попробуйте уточнить запрос. " + status);
            });
        }, clearSelection = function() {
            var selectedShape;
            return selectedShape ? (selectedShape.setEditable(!1), selectedShape = null) :void 0;
        }, setSelection = function(shape) {
            var selectedShape;
            return clearSelection(), selectedShape = shape, shape.setEditable(!0);
        }, update_vertices = function(shape) {
            return $("#deliveries_place_vertices").val(google.maps.geometry.encoding.encodePath(shape.getPath()));
        }, add_events_handler_to_shape = function(shape) {
            var allow_furher_adding;
            return allow_furher_adding = function() {
                return window.drawingManager.setDrawingMode(google.maps.drawing.OverlayType.POLYGON), 
                drawingManager.setOptions({
                    drawingControl:!0
                });
            }, google.maps.event.addListener(shape.getPath(), "set_at", function() {
                return update_vertices(shape);
            }), google.maps.event.addListener(shape.getPath(), "remove_at", function() {
                return update_vertices(shape);
            }), google.maps.event.addListener(shape.getPath(), "insert_at", function() {
                return update_vertices(shape);
            }), google.maps.event.addListener(shape, "rightclick", function(mev) {
                var path;
                return path = shape.getPath(), path.getLength() <= 3 ? (path.clear(), allow_furher_adding()) :null != mev.vertex ? shape.getPath().removeAt(mev.vertex) :void 0;
            });
        }, initialize = function() {
            var dont_allow_further_adding, path, poly, polyOptions, zoom_and_center_to_polygon;
            return window.map = new google.maps.Map(document.getElementById("map"), {
                zoom:parseInt($("#deliveries_place_zoom").val()),
                center:new google.maps.LatLng(parseFloat($("#deliveries_place_lat").val()), parseFloat($("#deliveries_place_lng").val())),
                mapTypeId:google.maps.MapTypeId.ROADMAP,
                disableDefaultUI:!0,
                zoomControl:!0
            }), google.maps.event.addListener(window.map, "zoom_changed", function() {
                return $("#deliveries_place_zoom").val(window.map.getZoom());
            }), google.maps.event.addListener(window.map, "bounds_changed", function() {
                return $("#deliveries_place_lat").val(window.map.getCenter().lat()), $("#deliveries_place_lng").val(window.map.getCenter().lng());
            }), polyOptions = {
                strokeWeight:0,
                fillOpacity:.45,
                editable:!0
            }, window.drawingManager = new google.maps.drawing.DrawingManager({
                drawingMode:google.maps.drawing.OverlayType.POLYGON,
                drawingControlOptions:{
                    drawingModes:[ google.maps.drawing.OverlayType.POLYGON ]
                },
                polygonOptions:polyOptions,
                map:window.map
            }), dont_allow_further_adding = function() {
                return window.drawingManager.setDrawingMode(null), drawingManager.setOptions({
                    drawingControl:!1
                });
            }, zoom_and_center_to_polygon = function() {
                var coords, lat, lng;
                return window.map.setZoom(parseInt($("#deliveries_place_zoom").val())), lat = parseFloat($("#deliveries_place_lat").val()), 
                lng = parseFloat($("#deliveries_place_lng").val()), coords = new google.maps.LatLng(lat, lng), 
                window.map.setCenter(coords);
            }, google.maps.event.addListener(window.drawingManager, "overlaycomplete", function(e) {
                var newShape;
                return dont_allow_further_adding(), newShape = e.overlay, newShape.type = e.type, 
                setSelection(newShape), update_vertices(newShape), add_events_handler_to_shape(newShape);
            }), "" !== $("#deliveries_place_vertices").val() && (poly = new google.maps.Polygon(polyOptions), 
            poly.setMap(map), path = google.maps.geometry.encoding.decodePath($("#deliveries_place_vertices").val()), 
            poly.setPath(path), setSelection(poly), add_events_handler_to_shape(poly), dont_allow_further_adding(), 
            zoom_and_center_to_polygon()), google.maps.event.addListener(window.drawingManager, "drawingmode_changed", clearSelection), 
            google.maps.event.addListener(window.map, "click", clearSelection);
        }, window.drawingManager = void 0, selectedShape = void 0, initialize();
    }, $(function() {
        return 0 !== $("#map").length ? $.cachedScript("http://maps.google.com/maps/api/js?sensor=false&libraries=drawing,geometry&callback=initMap") :void 0;
    }), $(document).on("page:load", function() {
        return 0 !== $("#map").length ? $.cachedScript("http://maps.google.com/maps/api/js?sensor=false&libraries=drawing,geometry&callback=initMap") :void 0;
    });
}.call(this), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, App.calcRoute = function(destination) {
        var directionsService, request;
        return request = {
            origin:$("#warehouse_address").text(),
            destination:destination,
            travelMode:eval("google.maps.TravelMode." + $("#travel_mode").text())
        }, console.log(request), directionsService = new google.maps.DirectionsService(), 
        directionsService.route(request, function(response, status) {
            var coords, delivery_cost, found, lat, leg, lng, marker, route;
            switch (status) {
              case google.maps.DirectionsStatus.OVER_QUERY_LIMIT:
                return alert("Превышена частота запросов, пожалуйста, попробуйте еще раз.");

              case google.maps.DirectionsStatus.ZERO_RESULTS:
              case google.maps.DirectionsStatus.NOT_FOUND:
                return alert("Указанный адрес не найден, попробуйте уточнить запрос");

              case google.maps.DirectionsStatus.OK:
                return 1 !== response.routes.length ? alert("routes != 1") :(route = response.routes[0], 
                1 !== route.legs.length ? alert("legs != 1") :(leg = route.legs[0], lat = leg.end_location.lat(), 
                lng = leg.end_location.lng(), coords = new google.maps.LatLng(lat, lng), found = void 0, 
                $(".delivery_zone").each(function() {
                    var poly;
                    return poly = $(this).data("polygon"), google.maps.geometry.poly.containsLocation(coords, poly) && (null == found || parseInt(poly.zIndex) > parseInt(found.data("polygon").zIndex)) ? found = $(this) :void 0;
                }), null != found ? found.data("polygon").activate(found) :"true" === $("#automatic_calculate_active").text() ? (window.map.setZoom(16), 
                window.map.setCenter(coords), marker = new google.maps.Marker({
                    map:window.map,
                    position:coords
                }), delivery_cost = Math.round(leg.duration.value / 60 * parseFloat($("#delivery_minute_cost").text())), 
                alert(delivery_cost > parseFloat($("#max_automatic_calculated_cost").text()) ? "Сожалеем, доставка по Вашему адресу не может быть осуществлена. TODO дописать" :"Стоимость доставки: TODO дописать" + delivery_cost)) :alert("Автоматический расчет стоимости доставки выключен. TODO дописать")));

              default:
                return alert(status);
            }
        });
    }, window.initClientMap = function() {
        var activate_polygon_and_marker, add_event_listener_to_object, previous_selected, zoom_and_move_to_common_style;
        return zoom_and_move_to_common_style = function(polygon) {
            var lat, lng, zoom;
            return lat = polygon.common_style.lat, lng = polygon.common_style.lng, zoom = polygon.common_style.zoom, 
            window.map.setZoom(zoom), window.map.setCenter(new google.maps.LatLng(lat, lng));
        }, previous_selected = void 0, activate_polygon_and_marker = function(that, func) {
            return "true" === that.find(".realize").text() || alert("Сожалеем, доставка по Вашему адресу не может быть осуществлена. Данная область не обслуживается. TODO дописать"), 
            previous_selected && previous_selected.inactivate(), that.closest(".accordion-group").find(".collapse").collapse("show"), 
            func.apply(null);
        }, google.maps.Polygon.prototype.activate = function(that) {
            var aaa;
            return aaa = this, activate_polygon_and_marker(that, function() {
                return previous_selected = aaa, zoom_and_move_to_common_style(aaa), aaa.setOptions(aaa.active_style);
            });
        }, google.maps.Polygon.prototype.inactivate = function() {
            return this.setOptions(this.inactive_style);
        }, google.maps.Marker.prototype.activate = function(that) {
            var aaa;
            return aaa = this, activate_polygon_and_marker(that, function() {
                return previous_selected = aaa.polygon, zoom_and_move_to_common_style(aaa.polygon), 
                aaa.polygon.setOptions(aaa.polygon.active_style);
            });
        }, google.maps.Marker.prototype.inactivate = function() {
            return this.polygon.setOptions(this.polygon.inactive_style);
        }, $(".delivery_zone a").on("click", function() {
            var dz;
            return dz = $(this).closest(".delivery_zone"), dz.data("polygon").activate(dz);
        }), add_event_listener_to_object = function(object, that) {
            return google.maps.event.addListener(object, "click", function() {
                return object.activate(that);
            });
        }, window.map = new google.maps.Map(document.getElementById("clientMap"), {
            zoom:parseInt($("#initial_map_zoom").text()),
            center:new google.maps.LatLng(parseFloat($("#initial_map_lat").text()), parseFloat($("#initial_map_lng").text())),
            mapTypeId:google.maps.MapTypeId.ROADMAP,
            disableDefaultUI:!0,
            zoomControl:!0,
            scrollwheel:!1
        }), $(".delivery_zone").each(function() {
            var bounds, marker, path, poly, step, _i, _len;
            if (path = google.maps.geometry.encoding.decodePath($(this).find(".vertices").text()), 
            poly = new google.maps.Polygon({
                zIndex:$(this).find(".z_index").text()
            }), poly.common_style = {
                zoom:parseInt($(this).find(".zoom").text()),
                lat:parseFloat($(this).find(".lat").text()),
                lng:parseFloat($(this).find(".lng").text())
            }, poly.active_style = {
                fillColor:$(this).find(".active .fill_color").text(),
                fillOpacity:$(this).find(".active .fill_opacity").text(),
                strokeColor:$(this).find(".active .stroke_color").text(),
                strokeOpacity:$(this).find(".active .stroke_opacity").text(),
                strokeWeight:$(this).find(".active .stroke_weight").text()
            }, poly.inactive_style = {
                fillColor:$(this).find(".inactive .fill_color").text(),
                fillOpacity:$(this).find(".inactive .fill_opacity").text(),
                strokeColor:$(this).find(".inactive .stroke_color").text(),
                strokeOpacity:$(this).find(".inactive .stroke_opacity").text(),
                strokeWeight:$(this).find(".inactive .stroke_weight").text()
            }, poly.inactivate(), poly.setMap(window.map), poly.setPath(path), $(this).data("polygon", poly), 
            add_event_listener_to_object(poly, $(this)), "true" === $(this).find(".display_marker").text()) {
                for (bounds = new google.maps.LatLngBounds(), _i = 0, _len = path.length; _len > _i; _i++) step = path[_i], 
                bounds.extend(step);
                return marker = new google.maps.Marker({
                    position:bounds.getCenter(),
                    title:$(this).find(".accordion-toggle strong").text()
                }), marker.polygon = poly, marker.setMap(window.map), add_event_listener_to_object(marker, $(this));
            }
        });
    }, $(function() {
        return 0 !== $("#clientMap").length ? $.cachedScript("http://maps.google.com/maps/api/js?sensor=false&libraries=geometry&callback=initClientMap") :void 0;
    }), $(document).on("page:load", function() {
        return 0 !== $("#clientMap").length ? $.cachedScript("http://maps.google.com/maps/api/js?sensor=false&libraries=geometry&callback=initClientMap") :void 0;
    }), $(document).on("show.bs.collapse", '[data-parent="#deliveries-accordion"]', function() {
        return $(".in").collapse("hide");
    }), $(document).on("shown.bs.collapse", '[data-parent="#deliveries-accordion"]', function(event) {
        return $("html, body").animate({
            scrollTop:$(event.target).closest(".accordion-group").offset().top - 5
        }, "fast");
    });
}.call(this), function() {
    window.Application || (window.Application = {}), $(function() {}), Application.toTop = function() {
        return $("html, body").animate({
            scrollTop:0
        }, "fast");
    }, Application.showLoading = function() {
        return Application.toTop(), $("#loading").show(), $("#main").animate({
            opacity:0
        });
    }, Application.hideLoading = function() {
        return $("#loading").hide(), $("#main").animate({
            opacity:100
        });
    }, $(document).on("click", ".ajax-search", function() {
        return Application.showLoading();
    }), $(document).on("submit", ".ajax-form", function() {
        return Application.showLoading();
    }), $(document).on("page:receive", function() {
        return Application.hideLoading();
    });
}.call(this), function() {
    var start, stop;
    start = function() {
        return $("#items-progress").show();
    }, stop = function() {
        return $("#items-progress").hide();
    }, $(document).on("ajax:beforeSend", function(xhr) {
        return $(xhr.target).closest("#new_grid").length > 0 ? start() :void 0;
    }), $(document).on("ajax:complete", function(xhr) {
        return $(xhr.target).closest("#new_grid").length > 0 ? stop() :void 0;
    });
}.call(this), function() {
    var auth_window;
    auth_window = void 0, $(document).on("click", "#auth-buttons a", function(event) {
        return event.preventDefault(), auth_window = window.open($(this).attr("href"), "login", "scrollbars=no, resizable=no, width=" + $(this).data("width") + ", height=" + $(this).data("height"));
    }), $(document).on("auth_done", "#auth-result", function() {
        return auth_window.close();
    });
}.call(this), function() {
    var makeEditable;
    makeEditable = function() {
        return $(".editable").each(function() {
            return $(this).attr("contenteditable", "true"), CKEDITOR.inline(this, window.extended_options), 
            $(this).editableHighlight();
        });
    }, $(document).on("click", "#edit", function(e) {
        return e.preventDefault(), CKEDITOR.disableAutoInline = !0, makeEditable();
    }), $(document).on("click", "#save", function() {
        var data;
        return data = CKEDITOR.instances.editable.getData(), $("#content").val(data), $(CKEDITOR.instances.editable.element.$).editableHighlight(), 
        CKEDITOR.instances.editable.destroy(), $(".editable").removeAttr("contenteditable");
    }), $(document).on("socket.joined", function() {
        return window.socket.on("rails.stats.create", function(msg) {
            return console.log($.parseJSON(msg));
        }), window.socket.on("rails.calls.create", function(msg) {
            return console.log($.parseJSON(msg));
        }), window.socket.on("rails.geo1.create", function(msg) {
            return console.log($.parseJSON(msg));
        });
    });
}.call(this), function() {
    jQuery.fn.editableHighlight = function() {
        return $(this).each(function() {
            var el;
            return el = $(this), el.before("<div/>"), el.prev().width(el.width()).height(el.height()).css({
                position:"absolute",
                "background-color":"#ffff99",
                opacity:".9"
            }).fadeOut(1500);
        });
    };
}.call(this), /*!
 * jQuery Cookie Plugin v1.4.0
 * https://github.com/carhartl/jquery-cookie
 *
 * Copyright 2013 Klaus Hartl
 * Released under the MIT license
 */
function(factory) {
    "function" == typeof define && define.amd ? define([ "jquery" ], factory) :factory(jQuery);
}(function($) {
    function encode(s) {
        return config.raw ? s :encodeURIComponent(s);
    }
    function decode(s) {
        return config.raw ? s :decodeURIComponent(s);
    }
    function stringifyCookieValue(value) {
        return encode(config.json ? JSON.stringify(value) :String(value));
    }
    function parseCookieValue(s) {
        0 === s.indexOf('"') && (s = s.slice(1, -1).replace(/\\"/g, '"').replace(/\\\\/g, "\\"));
        try {
            return s = decodeURIComponent(s.replace(pluses, " ")), config.json ? JSON.parse(s) :s;
        } catch (e) {}
    }
    function read(s, converter) {
        var value = config.raw ? s :parseCookieValue(s);
        return $.isFunction(converter) ? converter(value) :value;
    }
    var pluses = /\+/g, config = $.cookie = function(key, value, options) {
        if (void 0 !== value && !$.isFunction(value)) {
            if (options = $.extend({}, config.defaults, options), "number" == typeof options.expires) {
                var days = options.expires, t = options.expires = new Date();
                t.setTime(+t + 864e5 * days);
            }
            return document.cookie = [ encode(key), "=", stringifyCookieValue(value), options.expires ? "; expires=" + options.expires.toUTCString() :"", options.path ? "; path=" + options.path :"", options.domain ? "; domain=" + options.domain :"", options.secure ? "; secure" :"" ].join("");
        }
        for (var result = key ? void 0 :{}, cookies = document.cookie ? document.cookie.split("; ") :[], i = 0, l = cookies.length; l > i; i++) {
            var parts = cookies[i].split("="), name = decode(parts.shift()), cookie = parts.join("=");
            if (key && key === name) {
                result = read(cookie, value);
                break;
            }
            key || void 0 === (cookie = read(cookie)) || (result[name] = cookie);
        }
        return result;
    };
    config.defaults = {}, $.removeCookie = function(key, options) {
        return void 0 === $.cookie(key) ? !1 :($.cookie(key, "", $.extend({}, options, {
            expires:-1
        })), !$.cookie(key));
    };
});

/* SockJS client, version 0.3.4.26.gf002, http://sockjs.org, MIT License

Copyright (c) 2011-2012 VMware, Inc.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
var JSON;

JSON || (JSON = {}), function() {
    function str(a, b) {
        var c, d, e, f, h, g = gap, i = b[a];
        switch (i && "object" == typeof i && "function" == typeof i.toJSON && (i = i.toJSON(a)), 
        "function" == typeof rep && (i = rep.call(b, a, i)), typeof i) {
          case "string":
            return quote(i);

          case "number":
            return isFinite(i) ? String(i) :"null";

          case "boolean":
          case "null":
            return String(i);

          case "object":
            if (!i) return "null";
            if (gap += indent, h = [], "[object Array]" === Object.prototype.toString.apply(i)) {
                for (f = i.length, c = 0; f > c; c += 1) h[c] = str(c, i) || "null";
                return e = 0 === h.length ? "[]" :gap ? "[\n" + gap + h.join(",\n" + gap) + "\n" + g + "]" :"[" + h.join(",") + "]", 
                gap = g, e;
            }
            if (rep && "object" == typeof rep) for (f = rep.length, c = 0; f > c; c += 1) "string" == typeof rep[c] && (d = rep[c], 
            e = str(d, i), e && h.push(quote(d) + (gap ? ": " :":") + e)); else for (d in i) Object.prototype.hasOwnProperty.call(i, d) && (e = str(d, i), 
            e && h.push(quote(d) + (gap ? ": " :":") + e));
            return e = 0 === h.length ? "{}" :gap ? "{\n" + gap + h.join(",\n" + gap) + "\n" + g + "}" :"{" + h.join(",") + "}", 
            gap = g, e;
        }
    }
    function quote(a) {
        return escapable.lastIndex = 0, escapable.test(a) ? '"' + a.replace(escapable, function(a) {
            var b = meta[a];
            return "string" == typeof b ? b :"\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4);
        }) + '"' :'"' + a + '"';
    }
    function f(a) {
        return 10 > a ? "0" + a :a;
    }
    "function" != typeof Date.prototype.toJSON && (Date.prototype.toJSON = function() {
        return isFinite(this.valueOf()) ? this.getUTCFullYear() + "-" + f(this.getUTCMonth() + 1) + "-" + f(this.getUTCDate()) + "T" + f(this.getUTCHours()) + ":" + f(this.getUTCMinutes()) + ":" + f(this.getUTCSeconds()) + "Z" :null;
    }, String.prototype.toJSON = Number.prototype.toJSON = Boolean.prototype.toJSON = function() {
        return this.valueOf();
    });
    var cx = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, escapable = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, gap, indent, meta = {
        "\b":"\\b",
        "	":"\\t",
        "\n":"\\n",
        "\f":"\\f",
        "\r":"\\r",
        '"':'\\"',
        "\\":"\\\\"
    }, rep;
    "function" != typeof JSON.stringify && (JSON.stringify = function(a, b, c) {
        var d;
        if (gap = "", indent = "", "number" == typeof c) for (d = 0; c > d; d += 1) indent += " "; else "string" == typeof c && (indent = c);
        if (rep = b, !b || "function" == typeof b || "object" == typeof b && "number" == typeof b.length) return str("", {
            "":a
        });
        throw new Error("JSON.stringify");
    }), "function" != typeof JSON.parse && (JSON.parse = function(text, reviver) {
        function walk(a, b) {
            var c, d, e = a[b];
            if (e && "object" == typeof e) for (c in e) Object.prototype.hasOwnProperty.call(e, c) && (d = walk(e, c), 
            void 0 !== d ? e[c] = d :delete e[c]);
            return reviver.call(a, b, e);
        }
        var j;
        if (text = String(text), cx.lastIndex = 0, cx.test(text) && (text = text.replace(cx, function(a) {
            return "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4);
        })), /^[\],:{}\s]*$/.test(text.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, "@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]").replace(/(?:^|:|,)(?:\s*\[)+/g, ""))) return j = eval("(" + text + ")"), 
        "function" == typeof reviver ? walk({
            "":j
        }, "") :j;
        throw new SyntaxError("JSON.parse");
    });
}(), SockJS = function() {
    var a = document, b = window, c = {}, d = function() {};
    d.prototype.addEventListener = function(a, b) {
        this._listeners || (this._listeners = {}), a in this._listeners || (this._listeners[a] = []);
        var d = this._listeners[a];
        -1 === c.arrIndexOf(d, b) && d.push(b);
    }, d.prototype.removeEventListener = function(a, b) {
        if (this._listeners && a in this._listeners) {
            var d = this._listeners[a], e = c.arrIndexOf(d, b);
            return -1 !== e ? void (d.length > 1 ? this._listeners[a] = d.slice(0, e).concat(d.slice(e + 1)) :delete this._listeners[a]) :void 0;
        }
    }, d.prototype.dispatchEvent = function(a) {
        var b = a.type, c = Array.prototype.slice.call(arguments, 0);
        if (this["on" + b] && this["on" + b].apply(this, c), this._listeners && b in this._listeners) for (var d = 0; d < this._listeners[b].length; d++) this._listeners[b][d].apply(this, c);
    };
    var e = function(a, b) {
        if (this.type = a, "undefined" != typeof b) for (var c in b) b.hasOwnProperty(c) && (this[c] = b[c]);
    };
    e.prototype.toString = function() {
        var a = [];
        for (var b in this) if (this.hasOwnProperty(b)) {
            var c = this[b];
            "function" == typeof c && (c = "[function]"), a.push(b + "=" + c);
        }
        return "SimpleEvent(" + a.join(", ") + ")";
    };
    var f = function(a) {
        var b = this;
        b._events = a || [], b._listeners = {};
    };
    f.prototype.emit = function(a) {
        var b = this;
        if (b._verifyType(a), !b._nuked) {
            var c = Array.prototype.slice.call(arguments, 1);
            if (b["on" + a] && b["on" + a].apply(b, c), a in b._listeners) for (var d = 0; d < b._listeners[a].length; d++) b._listeners[a][d].apply(b, c);
        }
    }, f.prototype.on = function(a, b) {
        var c = this;
        c._verifyType(a), c._nuked || (a in c._listeners || (c._listeners[a] = []), c._listeners[a].push(b));
    }, f.prototype._verifyType = function(a) {
        var b = this;
        -1 === c.arrIndexOf(b._events, a) && c.log("Event " + JSON.stringify(a) + " not listed " + JSON.stringify(b._events) + " in " + b);
    }, f.prototype.nuke = function() {
        var a = this;
        a._nuked = !0;
        for (var b = 0; b < a._events.length; b++) delete a[a._events[b]];
        a._listeners = {};
    };
    var g = "abcdefghijklmnopqrstuvwxyz0123456789_";
    c.random_string = function(a, b) {
        b = b || g.length;
        var c, d = [];
        for (c = 0; a > c; c++) d.push(g.substr(Math.floor(Math.random() * b), 1));
        return d.join("");
    }, c.random_number = function(a) {
        return Math.floor(Math.random() * a);
    }, c.random_number_string = function(a) {
        var b = ("" + (a - 1)).length, d = Array(b + 1).join("0");
        return (d + c.random_number(a)).slice(-b);
    }, c.getOrigin = function(a) {
        a += "/";
        var b = a.split("/").slice(0, 3);
        return b.join("/");
    }, c.isSameOriginUrl = function(a, c) {
        return c || (c = b.location.href), a.split("/").slice(0, 3).join("/") === c.split("/").slice(0, 3).join("/");
    }, c.getParentDomain = function(a) {
        if (/^[0-9.]*$/.test(a)) return a;
        if (/^\[/.test(a)) return a;
        if (!/[.]/.test(a)) return a;
        var b = a.split(".").slice(1);
        return b.join(".");
    }, c.objectExtend = function(a, b) {
        for (var c in b) b.hasOwnProperty(c) && (a[c] = b[c]);
        return a;
    };
    var h = "_jp";
    c.polluteGlobalNamespace = function() {
        h in b || (b[h] = {});
    }, c.closeFrame = function(a, b) {
        return "c" + JSON.stringify([ a, b ]);
    }, c.userSetCode = function(a) {
        return 1e3 === a || a >= 3e3 && 4999 >= a;
    }, c.countRTO = function(a) {
        var b;
        return b = a > 100 ? 3 * a :a + 200;
    }, c.log = function() {
        b.console && console.log && console.log.apply && console.log.apply(console, arguments);
    }, c.bind = function(a, b) {
        return a.bind ? a.bind(b) :function() {
            return a.apply(b, arguments);
        };
    }, c.flatUrl = function(a) {
        return -1 === a.indexOf("?") && -1 === a.indexOf("#");
    }, c.amendUrl = function(b) {
        var d = a.location;
        if (!b) throw new Error("Wrong url for SockJS");
        if (!c.flatUrl(b)) throw new Error("Only basic urls are supported in SockJS");
        0 === b.indexOf("//") && (b = d.protocol + b), 0 === b.indexOf("/") && (b = d.protocol + "//" + d.host + b), 
        b = b.replace(/[/]+$/, "");
        var e = b.split("/");
        return ("http:" === e[0] && /:80$/.test(e[2]) || "https:" === e[0] && /:443$/.test(e[2])) && (e[2] = e[2].replace(/:(80|443)$/, "")), 
        b = e.join("/");
    }, c.arrIndexOf = function(a, b) {
        for (var c = 0; c < a.length; c++) if (a[c] === b) return c;
        return -1;
    }, c.arrSkip = function(a, b) {
        var d = c.arrIndexOf(a, b);
        if (-1 === d) return a.slice();
        var e = a.slice(0, d);
        return e.concat(a.slice(d + 1));
    }, c.isArray = Array.isArray || function(a) {
        return {}.toString.call(a).indexOf("Array") >= 0;
    }, c.delay = function(a, b) {
        return "function" == typeof a && (b = a, a = 0), setTimeout(b, a);
    };
    var l, i = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, j = {
        "\x00":"\\u0000",
        "":"\\u0001",
        "":"\\u0002",
        "":"\\u0003",
        "":"\\u0004",
        "":"\\u0005",
        "":"\\u0006",
        "":"\\u0007",
        "\b":"\\b",
        "	":"\\t",
        "\n":"\\n",
        "":"\\u000b",
        "\f":"\\f",
        "\r":"\\r",
        "":"\\u000e",
        "":"\\u000f",
        "":"\\u0010",
        "":"\\u0011",
        "":"\\u0012",
        "":"\\u0013",
        "":"\\u0014",
        "":"\\u0015",
        "":"\\u0016",
        "":"\\u0017",
        "":"\\u0018",
        "":"\\u0019",
        "":"\\u001a",
        "":"\\u001b",
        "":"\\u001c",
        "":"\\u001d",
        "":"\\u001e",
        "":"\\u001f",
        '"':'\\"',
        "\\":"\\\\",
        "":"\\u007f",
        "":"\\u0080",
        "":"\\u0081",
        "":"\\u0082",
        "":"\\u0083",
        "":"\\u0084",
        "":"\\u0085",
        "":"\\u0086",
        "":"\\u0087",
        "":"\\u0088",
        "":"\\u0089",
        "":"\\u008a",
        "":"\\u008b",
        "":"\\u008c",
        "":"\\u008d",
        "":"\\u008e",
        "":"\\u008f",
        "":"\\u0090",
        "":"\\u0091",
        "":"\\u0092",
        "":"\\u0093",
        "":"\\u0094",
        "":"\\u0095",
        "":"\\u0096",
        "":"\\u0097",
        "":"\\u0098",
        "":"\\u0099",
        "":"\\u009a",
        "":"\\u009b",
        "":"\\u009c",
        "":"\\u009d",
        "":"\\u009e",
        "":"\\u009f",
        "­":"\\u00ad",
        "؀":"\\u0600",
        "؁":"\\u0601",
        "؂":"\\u0602",
        "؃":"\\u0603",
        "؄":"\\u0604",
        "܏":"\\u070f",
        "឴":"\\u17b4",
        "឵":"\\u17b5",
        "‌":"\\u200c",
        "‍":"\\u200d",
        "‎":"\\u200e",
        "‏":"\\u200f",
        "\u2028":"\\u2028",
        "\u2029":"\\u2029",
        "‪":"\\u202a",
        "‫":"\\u202b",
        "‬":"\\u202c",
        "‭":"\\u202d",
        "‮":"\\u202e",
        " ":"\\u202f",
        "⁠":"\\u2060",
        "⁡":"\\u2061",
        "⁢":"\\u2062",
        "⁣":"\\u2063",
        "⁤":"\\u2064",
        "⁥":"\\u2065",
        "⁦":"\\u2066",
        "⁧":"\\u2067",
        "⁨":"\\u2068",
        "⁩":"\\u2069",
        "⁪":"\\u206a",
        "⁫":"\\u206b",
        "⁬":"\\u206c",
        "⁭":"\\u206d",
        "⁮":"\\u206e",
        "⁯":"\\u206f",
        "﻿":"\\ufeff",
        "￰":"\\ufff0",
        "￱":"\\ufff1",
        "￲":"\\ufff2",
        "￳":"\\ufff3",
        "￴":"\\ufff4",
        "￵":"\\ufff5",
        "￶":"\\ufff6",
        "￷":"\\ufff7",
        "￸":"\\ufff8",
        "￹":"\\ufff9",
        "￺":"\\ufffa",
        "￻":"\\ufffb",
        "￼":"\\ufffc",
        "�":"\\ufffd",
        "￾":"\\ufffe",
        "￿":"\\uffff"
    }, k = /[\x00-\x1f\ud800-\udfff\ufffe\uffff\u0300-\u0333\u033d-\u0346\u034a-\u034c\u0350-\u0352\u0357-\u0358\u035c-\u0362\u0374\u037e\u0387\u0591-\u05af\u05c4\u0610-\u0617\u0653-\u0654\u0657-\u065b\u065d-\u065e\u06df-\u06e2\u06eb-\u06ec\u0730\u0732-\u0733\u0735-\u0736\u073a\u073d\u073f-\u0741\u0743\u0745\u0747\u07eb-\u07f1\u0951\u0958-\u095f\u09dc-\u09dd\u09df\u0a33\u0a36\u0a59-\u0a5b\u0a5e\u0b5c-\u0b5d\u0e38-\u0e39\u0f43\u0f4d\u0f52\u0f57\u0f5c\u0f69\u0f72-\u0f76\u0f78\u0f80-\u0f83\u0f93\u0f9d\u0fa2\u0fa7\u0fac\u0fb9\u1939-\u193a\u1a17\u1b6b\u1cda-\u1cdb\u1dc0-\u1dcf\u1dfc\u1dfe\u1f71\u1f73\u1f75\u1f77\u1f79\u1f7b\u1f7d\u1fbb\u1fbe\u1fc9\u1fcb\u1fd3\u1fdb\u1fe3\u1feb\u1fee-\u1fef\u1ff9\u1ffb\u1ffd\u2000-\u2001\u20d0-\u20d1\u20d4-\u20d7\u20e7-\u20e9\u2126\u212a-\u212b\u2329-\u232a\u2adc\u302b-\u302c\uaab2-\uaab3\uf900-\ufa0d\ufa10\ufa12\ufa15-\ufa1e\ufa20\ufa22\ufa25-\ufa26\ufa2a-\ufa2d\ufa30-\ufa6d\ufa70-\ufad9\ufb1d\ufb1f\ufb2a-\ufb36\ufb38-\ufb3c\ufb3e\ufb40-\ufb41\ufb43-\ufb44\ufb46-\ufb4e\ufff0-\uffff]/g, m = JSON && JSON.stringify || function(a) {
        return i.lastIndex = 0, i.test(a) && (a = a.replace(i, function(a) {
            return j[a];
        })), '"' + a + '"';
    }, n = function(a) {
        var b, c = {}, d = [];
        for (b = 0; 65536 > b; b++) d.push(String.fromCharCode(b));
        return a.lastIndex = 0, d.join("").replace(a, function(a) {
            return c[a] = "\\u" + ("0000" + a.charCodeAt(0).toString(16)).slice(-4), "";
        }), a.lastIndex = 0, c;
    };
    c.quote = function(a) {
        var b = m(a);
        return k.lastIndex = 0, k.test(b) ? (l || (l = n(k)), b.replace(k, function(a) {
            return l[a];
        })) :b;
    };
    var o = [ "websocket", "xdr-streaming", "xhr-streaming", "iframe-eventsource", "iframe-htmlfile", "xdr-polling", "xhr-polling", "iframe-xhr-polling", "jsonp-polling" ];
    c.probeProtocols = function() {
        for (var a = {}, b = 0; b < o.length; b++) {
            var c = o[b];
            a[c] = y[c] && y[c].enabled();
        }
        return a;
    }, c.detectProtocols = function(a, b, c) {
        var d = {}, e = [];
        b || (b = o);
        for (var f = 0; f < b.length; f++) {
            var g = b[f];
            d[g] = a[g];
        }
        var h = function(a) {
            var b = a.shift();
            d[b] ? e.push(b) :a.length > 0 && h(a);
        };
        return c.websocket !== !1 && h([ "websocket" ]), d["xhr-streaming"] && !c.null_origin ? e.push("xhr-streaming") :!d["xdr-streaming"] || c.cookie_needed || c.null_origin ? h([ "iframe-eventsource", "iframe-htmlfile" ]) :e.push("xdr-streaming"), 
        d["xhr-polling"] && !c.null_origin ? e.push("xhr-polling") :!d["xdr-polling"] || c.cookie_needed || c.null_origin ? h([ "iframe-xhr-polling", "jsonp-polling" ]) :e.push("xdr-polling"), 
        e;
    };
    var p = "_sockjs_global";
    c.createHook = function() {
        var a = "a" + c.random_string(8);
        if (!(p in b)) {
            var d = {};
            b[p] = function(a) {
                return a in d || (d[a] = {
                    id:a,
                    del:function() {
                        delete d[a];
                    }
                }), d[a];
            };
        }
        return b[p](a);
    }, c.attachMessage = function(a) {
        c.attachEvent("message", a);
    }, c.attachEvent = function(c, d) {
        "undefined" != typeof b.addEventListener ? b.addEventListener(c, d, !1) :(a.attachEvent("on" + c, d), 
        b.attachEvent("on" + c, d));
    }, c.detachMessage = function(a) {
        c.detachEvent("message", a);
    }, c.detachEvent = function(c, d) {
        "undefined" != typeof b.addEventListener ? b.removeEventListener(c, d, !1) :(a.detachEvent("on" + c, d), 
        b.detachEvent("on" + c, d));
    };
    var q = {}, r = !1, s = function() {
        for (var a in q) q[a](), delete q[a];
    }, t = function() {
        r || (r = !0, s());
    };
    c.attachEvent("unload", t), c.unload_add = function(a) {
        var b = c.random_string(8);
        return q[b] = a, r && c.delay(s), b;
    }, c.unload_del = function(a) {
        a in q && delete q[a];
    }, c.createIframe = function(b, d) {
        var f, g, e = a.createElement("iframe"), h = function() {
            clearTimeout(f);
            try {
                e.onload = null;
            } catch (a) {}
            e.onerror = null;
        }, i = function() {
            e && (h(), setTimeout(function() {
                e && e.parentNode.removeChild(e), e = null;
            }, 0), c.unload_del(g));
        }, j = function(a) {
            e && (i(), d(a));
        }, k = function(a, b) {
            try {
                e && e.contentWindow && e.contentWindow.postMessage(a, b);
            } catch (c) {}
        };
        return e.src = b, e.style.display = "none", e.style.position = "absolute", e.onerror = function() {
            j("onerror");
        }, e.onload = function() {
            clearTimeout(f), f = setTimeout(function() {
                j("onload timeout");
            }, 2e3);
        }, a.body.appendChild(e), f = setTimeout(function() {
            j("timeout");
        }, 15e3), g = c.unload_add(i), {
            post:k,
            cleanup:i,
            loaded:h
        };
    }, c.createHtmlfile = function(a, d) {
        var f, g, i, e = new ActiveXObject("htmlfile"), j = function() {
            clearTimeout(f);
        }, k = function() {
            e && (j(), c.unload_del(g), i.parentNode.removeChild(i), i = e = null, CollectGarbage());
        }, l = function(a) {
            e && (k(), d(a));
        }, m = function(a, b) {
            try {
                i && i.contentWindow && i.contentWindow.postMessage(a, b);
            } catch (c) {}
        };
        e.open(), e.write('<html><script>document.domain="' + document.domain + '";</script></html>'), 
        e.close(), e.parentWindow[h] = b[h];
        var n = e.createElement("div");
        return e.body.appendChild(n), i = e.createElement("iframe"), n.appendChild(i), i.src = a, 
        f = setTimeout(function() {
            l("timeout");
        }, 15e3), g = c.unload_add(k), {
            post:m,
            cleanup:k,
            loaded:j
        };
    };
    var u = function() {};
    u.prototype = new f([ "chunk", "finish" ]), u.prototype._start = function(a, d, e, f) {
        var g = this;
        try {
            g.xhr = new XMLHttpRequest();
        } catch (h) {}
        if (!g.xhr) try {
            g.xhr = new b.ActiveXObject("Microsoft.XMLHTTP");
        } catch (h) {}
        (b.ActiveXObject || b.XDomainRequest) && (d += (-1 === d.indexOf("?") ? "?" :"&") + "t=" + +new Date()), 
        g.unload_ref = c.unload_add(function() {
            g._cleanup(!0);
        });
        try {
            g.xhr.open(a, d, !0);
        } catch (i) {
            return g.emit("finish", 0, ""), void g._cleanup();
        }
        if (f && f.no_credentials || (g.xhr.withCredentials = "true"), f && f.headers) for (var j in f.headers) g.xhr.setRequestHeader(j, f.headers[j]);
        g.xhr.onreadystatechange = function() {
            if (g.xhr) {
                var a = g.xhr;
                switch (a.readyState) {
                  case 3:
                    try {
                        var b = a.status, c = a.responseText;
                    } catch (d) {}
                    1223 === b && (b = 204), c && c.length > 0 && g.emit("chunk", b, c);
                    break;

                  case 4:
                    var b = a.status;
                    1223 === b && (b = 204), g.emit("finish", b, a.responseText), g._cleanup(!1);
                }
            }
        }, g.xhr.send(e);
    }, u.prototype._cleanup = function(a) {
        var b = this;
        if (b.xhr) {
            if (c.unload_del(b.unload_ref), b.xhr.onreadystatechange = function() {}, a) try {
                b.xhr.abort();
            } catch (d) {}
            b.unload_ref = b.xhr = null;
        }
    }, u.prototype.close = function() {
        var a = this;
        a.nuke(), a._cleanup(!0);
    };
    var v = c.XHRCorsObject = function() {
        var a = this, b = arguments;
        c.delay(function() {
            a._start.apply(a, b);
        });
    };
    v.prototype = new u();
    var w = c.XHRLocalObject = function(a, b, d) {
        var e = this;
        c.delay(function() {
            e._start(a, b, d, {
                no_credentials:!0
            });
        });
    };
    w.prototype = new u();
    var x = c.XDRObject = function(a, b, d) {
        var e = this;
        c.delay(function() {
            e._start(a, b, d);
        });
    };
    x.prototype = new f([ "chunk", "finish" ]), x.prototype._start = function(a, b, d) {
        var e = this, f = new XDomainRequest();
        b += (-1 === b.indexOf("?") ? "?" :"&") + "t=" + +new Date();
        var g = f.ontimeout = f.onerror = function() {
            e.emit("finish", 0, ""), e._cleanup(!1);
        };
        f.onprogress = function() {
            e.emit("chunk", 200, f.responseText);
        }, f.onload = function() {
            e.emit("finish", 200, f.responseText), e._cleanup(!1);
        }, e.xdr = f, e.unload_ref = c.unload_add(function() {
            e._cleanup(!0);
        });
        try {
            e.xdr.open(a, b), e.xdr.send(d);
        } catch (h) {
            g();
        }
    }, x.prototype._cleanup = function(a) {
        var b = this;
        if (b.xdr) {
            if (c.unload_del(b.unload_ref), b.xdr.ontimeout = b.xdr.onerror = b.xdr.onprogress = b.xdr.onload = null, 
            a) try {
                b.xdr.abort();
            } catch (d) {}
            b.unload_ref = b.xdr = null;
        }
    }, x.prototype.close = function() {
        var a = this;
        a.nuke(), a._cleanup(!0);
    }, c.isXHRCorsCapable = function() {
        return b.XMLHttpRequest && "withCredentials" in new XMLHttpRequest() ? 1 :b.XDomainRequest && a.domain ? 2 :L.enabled() ? 3 :4;
    };
    var y = function(a, b, d) {
        if (!(this instanceof y)) return new y(a, b, d);
        var f, e = this;
        e._options = {
            devel:!1,
            debug:!1,
            protocols_whitelist:[],
            info:void 0,
            rtt:void 0
        }, d && c.objectExtend(e._options, d), e._base_url = c.amendUrl(a), e._server = e._options.server || c.random_number_string(1e3), 
        e._options.protocols_whitelist && e._options.protocols_whitelist.length ? f = e._options.protocols_whitelist :(f = "string" == typeof b && b.length > 0 ? [ b ] :c.isArray(b) ? b :null, 
        f && e._debug('Deprecated API: Use "protocols_whitelist" option instead of supplying protocol list as a second parameter to SockJS constructor.')), 
        e._protocols = [], e.protocol = null, e.readyState = y.CONNECTING, e._ir = S(e._base_url), 
        e._ir.onfinish = function(a, b) {
            e._ir = null, a ? (e._options.info && (a = c.objectExtend(a, e._options.info)), 
            e._options.rtt && (b = e._options.rtt), e._applyInfo(a, b, f), e._didClose()) :e._didClose(1002, "Can't connect to server", !0);
        };
    };
    y.prototype = new d(), y.version = "0.3.4.26.gf002", y.prototype.CONNECTING = y.CONNECTING = 0, 
    y.prototype.OPEN = y.OPEN = 1, y.prototype.CLOSING = y.CLOSING = 2, y.prototype.CLOSED = y.CLOSED = 3, 
    y.prototype._debug = function() {
        this._options.debug && c.log.apply(c, arguments);
    }, y.prototype._dispatchOpen = function() {
        var a = this;
        a.readyState === y.CONNECTING ? (a._transport_tref && (clearTimeout(a._transport_tref), 
        a._transport_tref = null), a.readyState = y.OPEN, a.dispatchEvent(new e("open"))) :a._didClose(1006, "Server lost session");
    }, y.prototype._dispatchMessage = function(a) {
        var b = this;
        b.readyState === y.OPEN && b.dispatchEvent(new e("message", {
            data:a
        }));
    }, y.prototype._dispatchHeartbeat = function() {
        var b = this;
        b.readyState === y.OPEN && b.dispatchEvent(new e("heartbeat", {}));
    }, y.prototype._didClose = function(a, b, d) {
        var f = this;
        if (f.readyState !== y.CONNECTING && f.readyState !== y.OPEN && f.readyState !== y.CLOSING) throw new Error("INVALID_STATE_ERR");
        f._ir && (f._ir.nuke(), f._ir = null), f._transport && (f._transport.doCleanup(), 
        f._transport = null);
        var g = new e("close", {
            code:a,
            reason:b,
            wasClean:c.userSetCode(a)
        });
        if (!c.userSetCode(a) && f.readyState === y.CONNECTING && !d) {
            if (f._try_next_protocol(g)) return;
            g = new e("close", {
                code:2e3,
                reason:"All transports failed",
                wasClean:!1,
                last_event:g
            });
        }
        f.readyState = y.CLOSED, c.delay(function() {
            f.dispatchEvent(g);
        });
    }, y.prototype._didMessage = function(a) {
        var b = this, c = a.slice(0, 1);
        switch (c) {
          case "o":
            b._dispatchOpen();
            break;

          case "a":
            for (var d = JSON.parse(a.slice(1) || "[]"), e = 0; e < d.length; e++) b._dispatchMessage(d[e]);
            break;

          case "m":
            var d = JSON.parse(a.slice(1) || "null");
            b._dispatchMessage(d);
            break;

          case "c":
            var d = JSON.parse(a.slice(1) || "[]");
            b._didClose(d[0], d[1]);
            break;

          case "h":
            b._dispatchHeartbeat();
        }
    }, y.prototype._try_next_protocol = function(b) {
        var d = this;
        for (d.protocol && (d._debug("Closed transport:", d.protocol, "" + b), d.protocol = null), 
        d._transport_tref && (clearTimeout(d._transport_tref), d._transport_tref = null); ;) {
            var e = d.protocol = d._protocols.shift();
            if (!e) return !1;
            if (y[e] && y[e].need_body === !0 && (!a.body || "undefined" != typeof a.readyState && "complete" !== a.readyState)) return d._protocols.unshift(e), 
            d.protocol = "waiting-for-load", c.attachEvent("load", function() {
                d._try_next_protocol();
            }), !0;
            if (y[e] && y[e].enabled(d._options)) {
                var f = y[e].roundTrips || 1, g = (d._options.rto || 0) * f || 5e3;
                d._transport_tref = c.delay(g, function() {
                    d.readyState === y.CONNECTING && d._didClose(2007, "Transport timeouted");
                });
                var h = c.random_string(8), i = d._base_url + "/" + d._server + "/" + h;
                return d._debug("Opening transport:", e, " url:" + i, " RTO:" + d._options.rto), 
                d._transport = new y[e](d, i, d._base_url), !0;
            }
            d._debug("Skipping transport:", e);
        }
    }, y.prototype.close = function(a, b) {
        var d = this;
        if (a && !c.userSetCode(a)) throw new Error("INVALID_ACCESS_ERR");
        return d.readyState !== y.CONNECTING && d.readyState !== y.OPEN ? !1 :(d.readyState = y.CLOSING, 
        d._didClose(a || 1e3, b || "Normal closure"), !0);
    }, y.prototype.send = function(a) {
        var b = this;
        if (b.readyState === y.CONNECTING) throw new Error("INVALID_STATE_ERR");
        return b.readyState === y.OPEN && b._transport.doSend(c.quote("" + a)), !0;
    }, y.prototype._applyInfo = function(b, d, e) {
        var f = this;
        f._options.info = b, f._options.rtt = d, f._options.rto = c.countRTO(d), f._options.info.null_origin = !a.domain, 
        b.base_url && (f._base_url = c.amendUrl(b.base_url));
        var g = c.probeProtocols();
        f._protocols = c.detectProtocols(g, e, b);
    };
    var z = y.websocket = function(a, d) {
        var e = this, f = d + "/websocket";
        f = "https" === f.slice(0, 5) ? "wss" + f.slice(5) :"ws" + f.slice(4), e.ri = a, 
        e.url = f;
        var g = b.WebSocket || b.MozWebSocket;
        e.ws = new g(e.url), e.ws.onmessage = function(a) {
            e.ri._didMessage(a.data);
        }, e.unload_ref = c.unload_add(function() {
            e.ws.close();
        }), e.ws.onclose = function() {
            e.ri._didMessage(c.closeFrame(1006, "WebSocket connection broken"));
        };
    };
    z.prototype.doSend = function(a) {
        this.ws.send("[" + a + "]");
    }, z.prototype.doCleanup = function() {
        var a = this, b = a.ws;
        b && (b.onmessage = b.onclose = null, b.close(), c.unload_del(a.unload_ref), a.unload_ref = a.ri = a.ws = null);
    }, z.enabled = function() {
        return !!b.WebSocket || !!b.MozWebSocket;
    }, z.roundTrips = 2;
    var A = function() {};
    A.prototype.send_constructor = function(a) {
        var b = this;
        b.send_buffer = [], b.sender = a;
    }, A.prototype.doSend = function(a) {
        var b = this;
        b.send_buffer.push(a), b.send_stop || b.send_schedule();
    }, A.prototype.send_schedule_wait = function() {
        var b, a = this;
        a.send_stop = function() {
            a.send_stop = null, clearTimeout(b);
        }, b = c.delay(25, function() {
            a.send_stop = null, a.send_schedule();
        });
    }, A.prototype.send_schedule = function() {
        var a = this;
        if (a.send_buffer.length > 0) {
            var b = "[" + a.send_buffer.join(",") + "]";
            a.send_stop = a.sender(a.trans_url, b, function(b, c) {
                a.send_stop = null, b === !1 ? a.ri._didClose(1006, "Sending error " + c) :a.send_schedule_wait();
            }), a.send_buffer = [];
        }
    }, A.prototype.send_destructor = function() {
        var a = this;
        a._send_stop && a._send_stop(), a._send_stop = null;
    };
    var B = function(b, d, e) {
        var f = this;
        if (!("_send_form" in f)) {
            var g = f._send_form = a.createElement("form"), h = f._send_area = a.createElement("textarea");
            h.name = "d", g.style.display = "none", g.style.position = "absolute", g.method = "POST", 
            g.enctype = "application/x-www-form-urlencoded", g.acceptCharset = "UTF-8", g.appendChild(h), 
            a.body.appendChild(g);
        }
        var g = f._send_form, h = f._send_area, i = "a" + c.random_string(8);
        g.target = i, g.action = b + "/jsonp_send?i=" + i;
        var j;
        try {
            j = a.createElement('<iframe name="' + i + '">');
        } catch (k) {
            j = a.createElement("iframe"), j.name = i;
        }
        j.id = i, g.appendChild(j), j.style.display = "none";
        try {
            h.value = d;
        } catch (l) {
            c.log("Your browser is seriously broken. Go home! " + l.message);
        }
        g.submit();
        var m = function() {
            j.onerror && (j.onreadystatechange = j.onerror = j.onload = null, c.delay(500, function() {
                j.parentNode.removeChild(j), j = null;
            }), h.value = "", e(!0));
        };
        return j.onerror = j.onload = m, j.onreadystatechange = function() {
            "complete" == j.readyState && m();
        }, m;
    }, C = function(a) {
        return function(b, c, d) {
            var e = new a("POST", b + "/xhr_send", c);
            return e.onfinish = function(a) {
                d(200 === a || 204 === a, "http status " + a);
            }, function(a) {
                d(!1, a);
            };
        };
    }, D = function(b, d) {
        var e, g, f = a.createElement("script"), h = function(a) {
            g && (g.parentNode.removeChild(g), g = null), f && (clearTimeout(e), f.parentNode.removeChild(f), 
            f.onreadystatechange = f.onerror = f.onload = f.onclick = null, f = null, d(a), 
            d = null);
        }, i = !1, j = null;
        if (f.id = "a" + c.random_string(8), f.src = b, f.type = "text/javascript", f.charset = "UTF-8", 
        f.onerror = function() {
            j || (j = setTimeout(function() {
                i || h(c.closeFrame(1006, "JSONP script loaded abnormally (onerror)"));
            }, 1e3));
        }, f.onload = function() {
            h(c.closeFrame(1006, "JSONP script loaded abnormally (onload)"));
        }, f.onreadystatechange = function() {
            if (/loaded|closed/.test(f.readyState)) {
                if (f && f.htmlFor && f.onclick) {
                    i = !0;
                    try {
                        f.onclick();
                    } catch (b) {}
                }
                f && h(c.closeFrame(1006, "JSONP script loaded abnormally (onreadystatechange)"));
            }
        }, "undefined" == typeof f.async && a.attachEvent) if (/opera/i.test(navigator.userAgent)) g = a.createElement("script"), 
        g.text = "try{var a = document.getElementById('" + f.id + "'); if(a)a.onerror();}catch(x){};", 
        f.async = g.async = !1; else {
            try {
                f.htmlFor = f.id, f.event = "onclick";
            } catch (k) {}
            f.async = !0;
        }
        "undefined" != typeof f.async && (f.async = !0), e = setTimeout(function() {
            h(c.closeFrame(1006, "JSONP script loaded abnormally (timeout)"));
        }, 35e3);
        var l = a.getElementsByTagName("head")[0];
        return l.insertBefore(f, l.firstChild), g && l.insertBefore(g, l.firstChild), h;
    }, E = y["jsonp-polling"] = function(a, b) {
        c.polluteGlobalNamespace();
        var d = this;
        d.ri = a, d.trans_url = b, d.send_constructor(B), d._schedule_recv();
    };
    E.prototype = new A(), E.prototype._schedule_recv = function() {
        var a = this, b = function(b) {
            a._recv_stop = null, b && (a._is_closing || a.ri._didMessage(b)), a._is_closing || a._schedule_recv();
        };
        a._recv_stop = F(a.trans_url + "/jsonp", D, b);
    }, E.enabled = function() {
        return !0;
    }, E.need_body = !0, E.prototype.doCleanup = function() {
        var a = this;
        a._is_closing = !0, a._recv_stop && a._recv_stop(), a.ri = a._recv_stop = null, 
        a.send_destructor();
    };
    var F = function(a, d, e) {
        var f = "a" + c.random_string(6), g = a + "?c=" + escape(h + "." + f), i = 0, j = function(a) {
            switch (i) {
              case 0:
                delete b[h][f], e(a);
                break;

              case 1:
                e(a), i = 2;
                break;

              case 2:
                delete b[h][f];
            }
        }, k = d(g, j);
        b[h][f] = k;
        var l = function() {
            b[h][f] && (i = 1, b[h][f](c.closeFrame(1e3, "JSONP user aborted read")));
        };
        return l;
    }, G = function() {};
    G.prototype = new A(), G.prototype.run = function(a, b, c, d, e) {
        var f = this;
        f.ri = a, f.trans_url = b, f.send_constructor(C(e)), f.poll = new $(a, d, b + c, e);
    }, G.prototype.doCleanup = function() {
        var a = this;
        a.poll && (a.poll.abort(), a.poll = null);
    };
    var H = y["xhr-streaming"] = function(a, b) {
        this.run(a, b, "/xhr_streaming", bd, c.XHRCorsObject);
    };
    H.prototype = new G(), H.enabled = function() {
        return b.XMLHttpRequest && "withCredentials" in new XMLHttpRequest() && !/opera/i.test(navigator.userAgent);
    }, H.roundTrips = 2, H.need_body = !0;
    var I = y["xdr-streaming"] = function(a, b) {
        this.run(a, b, "/xhr_streaming", bd, c.XDRObject);
    };
    I.prototype = new G(), I.enabled = function() {
        return !!b.XDomainRequest;
    }, I.roundTrips = 2;
    var J = y["xhr-polling"] = function(a, b) {
        this.run(a, b, "/xhr", bd, c.XHRCorsObject);
    };
    J.prototype = new G(), J.enabled = H.enabled, J.roundTrips = 2;
    var K = y["xdr-polling"] = function(a, b) {
        this.run(a, b, "/xhr", bd, c.XDRObject);
    };
    K.prototype = new G(), K.enabled = I.enabled, K.roundTrips = 2;
    var L = function() {};
    L.prototype.i_constructor = function(a, b, d) {
        var e = this;
        e.ri = a, e.origin = c.getOrigin(d), e.base_url = d, e.trans_url = b;
        var f = d + "/iframe.html";
        e.ri._options.devel && (f += "?t=" + +new Date()), e.window_id = c.random_string(8), 
        f += "#" + e.window_id, e.iframeObj = c.createIframe(f, function(a) {
            e.ri._didClose(1006, "Unable to load an iframe (" + a + ")");
        }), e.onmessage_cb = c.bind(e.onmessage, e), c.attachMessage(e.onmessage_cb);
    }, L.prototype.doCleanup = function() {
        var a = this;
        if (a.iframeObj) {
            c.detachMessage(a.onmessage_cb);
            try {
                a.iframeObj.iframe.contentWindow && a.postMessage("c");
            } catch (b) {}
            a.iframeObj.cleanup(), a.iframeObj = null, a.onmessage_cb = a.iframeObj = null;
        }
    }, L.prototype.onmessage = function(a) {
        var b = this;
        if (a.origin === b.origin) {
            var c = a.data.slice(0, 8), d = a.data.slice(8, 9), e = a.data.slice(9);
            if (c === b.window_id) switch (d) {
              case "s":
                b.iframeObj.loaded(), b.postMessage("s", JSON.stringify([ y.version, b.protocol, b.trans_url, b.base_url ]));
                break;

              case "t":
                b.ri._didMessage(e);
            }
        }
    }, L.prototype.postMessage = function(a, b) {
        var c = this;
        c.iframeObj.post(c.window_id + a + (b || ""), c.origin);
    }, L.prototype.doSend = function(a) {
        this.postMessage("m", a);
    }, L.enabled = function() {
        var a = navigator && navigator.userAgent && -1 !== navigator.userAgent.indexOf("Konqueror");
        return ("function" == typeof b.postMessage || "object" == typeof b.postMessage) && !a;
    };
    var M, N = function(a, d) {
        parent !== b ? parent.postMessage(M + a + (d || ""), "*") :c.log("Can't postMessage, no parent window.", a, d);
    }, O = function() {};
    O.prototype._didClose = function(a, b) {
        N("t", c.closeFrame(a, b));
    }, O.prototype._didMessage = function(a) {
        N("t", a);
    }, O.prototype._doSend = function(a) {
        this._transport.doSend(a);
    }, O.prototype._doCleanup = function() {
        this._transport.doCleanup();
    }, c.parent_origin = void 0, y.bootstrap_iframe = function() {
        var d;
        M = a.location.hash.slice(1);
        var e = function(a) {
            if (a.source === parent && ("undefined" == typeof c.parent_origin && (c.parent_origin = a.origin), 
            a.origin === c.parent_origin)) {
                var e = a.data.slice(0, 8), f = a.data.slice(8, 9), g = a.data.slice(9);
                if (e === M) switch (f) {
                  case "s":
                    var h = JSON.parse(g), i = h[0], j = h[1], k = h[2], l = h[3];
                    if (i !== y.version && c.log('Incompatibile SockJS! Main site uses: "' + i + '", the iframe: "' + y.version + '".'), 
                    !c.flatUrl(k) || !c.flatUrl(l)) return void c.log("Only basic urls are supported in SockJS");
                    if (!c.isSameOriginUrl(k) || !c.isSameOriginUrl(l)) return void c.log("Can't connect to different domain from within an iframe. (" + JSON.stringify([ b.location.href, k, l ]) + ")");
                    d = new O(), d._transport = new O[j](d, k, l);
                    break;

                  case "m":
                    d._doSend(g);
                    break;

                  case "c":
                    d && d._doCleanup(), d = null;
                }
            }
        };
        c.attachMessage(e), N("s");
    };
    var P = function(a, b) {
        var d = this;
        c.delay(function() {
            d.doXhr(a, b);
        });
    };
    P.prototype = new f([ "finish" ]), P.prototype.doXhr = function(a, b) {
        var d = this, e = new Date().getTime(), f = new b("GET", a + "/info"), g = c.delay(8e3, function() {
            f.ontimeout();
        });
        f.onfinish = function(a, b) {
            if (clearTimeout(g), g = null, 200 === a) {
                var c = new Date().getTime() - e, f = JSON.parse(b);
                "object" != typeof f && (f = {}), d.emit("finish", f, c);
            } else d.emit("finish");
        }, f.ontimeout = function() {
            f.close(), d.emit("finish");
        };
    };
    var Q = function(b) {
        var d = this, e = function() {
            var a = new L();
            a.protocol = "w-iframe-info-receiver";
            var c = function(b) {
                if ("string" == typeof b && "m" === b.substr(0, 1)) {
                    var c = JSON.parse(b.substr(1)), e = c[0], f = c[1];
                    d.emit("finish", e, f);
                } else d.emit("finish");
                a.doCleanup(), a = null;
            }, e = {
                _options:{},
                _didClose:c,
                _didMessage:c
            };
            a.i_constructor(e, b, b);
        };
        a.body ? e() :c.attachEvent("load", e);
    };
    Q.prototype = new f([ "finish" ]);
    var R = function() {
        var a = this;
        c.delay(function() {
            a.emit("finish", {}, 2e3);
        });
    };
    R.prototype = new f([ "finish" ]);
    var S = function(a) {
        if (c.isSameOriginUrl(a)) return new P(a, c.XHRLocalObject);
        switch (c.isXHRCorsCapable()) {
          case 1:
            return new P(a, c.XHRLocalObject);

          case 2:
            return new P(a, c.XDRObject);

          case 3:
            return new Q(a);

          default:
            return new R();
        }
    }, T = O["w-iframe-info-receiver"] = function(a, b, d) {
        var e = new P(d, c.XHRLocalObject);
        e.onfinish = function(b, c) {
            a._didMessage("m" + JSON.stringify([ b, c ])), a._didClose();
        };
    };
    T.prototype.doCleanup = function() {};
    var U = y["iframe-eventsource"] = function() {
        var a = this;
        a.protocol = "w-iframe-eventsource", a.i_constructor.apply(a, arguments);
    };
    U.prototype = new L(), U.enabled = function() {
        return "EventSource" in b && L.enabled();
    }, U.need_body = !0, U.roundTrips = 3;
    var V = O["w-iframe-eventsource"] = function(a, b) {
        this.run(a, b, "/eventsource", _, c.XHRLocalObject);
    };
    V.prototype = new G();
    var W = y["iframe-xhr-polling"] = function() {
        var a = this;
        a.protocol = "w-iframe-xhr-polling", a.i_constructor.apply(a, arguments);
    };
    W.prototype = new L(), W.enabled = function() {
        return b.XMLHttpRequest && L.enabled();
    }, W.need_body = !0, W.roundTrips = 3;
    var X = O["w-iframe-xhr-polling"] = function(a, b) {
        this.run(a, b, "/xhr", bd, c.XHRLocalObject);
    };
    X.prototype = new G();
    var Y = y["iframe-htmlfile"] = function() {
        var a = this;
        a.protocol = "w-iframe-htmlfile", a.i_constructor.apply(a, arguments);
    };
    Y.prototype = new L(), Y.enabled = function() {
        return L.enabled();
    }, Y.need_body = !0, Y.roundTrips = 3;
    var Z = O["w-iframe-htmlfile"] = function(a, b) {
        this.run(a, b, "/htmlfile", bc, c.XHRLocalObject);
    };
    Z.prototype = new G();
    var $ = function(a, b, c, d) {
        var e = this;
        e.ri = a, e.Receiver = b, e.recv_url = c, e.AjaxObject = d, e._scheduleRecv();
    };
    $.prototype._scheduleRecv = function() {
        var a = this, b = a.poll = new a.Receiver(a.recv_url, a.AjaxObject), c = 0;
        b.onmessage = function(b) {
            c += 1, a.ri._didMessage(b.data);
        }, b.onclose = function(c) {
            a.poll = b = b.onmessage = b.onclose = null, a.poll_is_closing || ("permanent" === c.reason ? a.ri._didClose(1006, "Polling error (" + c.reason + ")") :a._scheduleRecv());
        };
    }, $.prototype.abort = function() {
        var a = this;
        a.poll_is_closing = !0, a.poll && a.poll.abort();
    };
    var _ = function(a) {
        var b = this, d = new EventSource(a);
        d.onmessage = function(a) {
            b.dispatchEvent(new e("message", {
                data:unescape(a.data)
            }));
        }, b.es_close = d.onerror = function(a, f) {
            var g = f ? "user" :2 !== d.readyState ? "network" :"permanent";
            b.es_close = d.onmessage = d.onerror = null, d.close(), d = null, c.delay(200, function() {
                b.dispatchEvent(new e("close", {
                    reason:g
                }));
            });
        };
    };
    _.prototype = new d(), _.prototype.abort = function() {
        var a = this;
        a.es_close && a.es_close({}, !0);
    };
    var ba, bb = function() {
        if (void 0 === ba) if ("ActiveXObject" in b) try {
            ba = !!new ActiveXObject("htmlfile");
        } catch (a) {} else ba = !1;
        return ba;
    }, bc = function(a) {
        var d = this;
        c.polluteGlobalNamespace(), d.id = "a" + c.random_string(6, 26), a += (-1 === a.indexOf("?") ? "?" :"&") + "c=" + escape(h + "." + d.id);
        var g, f = bb() ? c.createHtmlfile :c.createIframe;
        b[h][d.id] = {
            start:function() {
                g.loaded();
            },
            message:function(a) {
                d.dispatchEvent(new e("message", {
                    data:a
                }));
            },
            stop:function() {
                d.iframe_close({}, "network");
            }
        }, d.iframe_close = function(a, c) {
            g.cleanup(), d.iframe_close = g = null, delete b[h][d.id], d.dispatchEvent(new e("close", {
                reason:c
            }));
        }, g = f(a, function() {
            d.iframe_close({}, "permanent");
        });
    };
    bc.prototype = new d(), bc.prototype.abort = function() {
        var a = this;
        a.iframe_close && a.iframe_close({}, "user");
    };
    var bd = function(a, b) {
        var c = this, d = 0;
        c.xo = new b("POST", a, null), c.xo.onchunk = function(a, b) {
            if (200 === a) for (;;) {
                var f = b.slice(d), g = f.indexOf("\n");
                if (-1 === g) break;
                d += g + 1;
                var h = f.slice(0, g);
                c.dispatchEvent(new e("message", {
                    data:h
                }));
            }
        }, c.xo.onfinish = function(a, b) {
            c.xo.onchunk(a, b), c.xo = null;
            var d = 200 === a ? "network" :"permanent";
            c.dispatchEvent(new e("close", {
                reason:d
            }));
        };
    };
    return bd.prototype = new d(), bd.prototype.abort = function() {
        var a = this;
        a.xo && (a.xo.close(), a.dispatchEvent(new e("close", {
            reason:"user"
        })), a.xo = null);
    }, y.getUtils = function() {
        return c;
    }, y.getIframeTransport = function() {
        return L;
    }, y;
}(), "_sockjs_onload" in window && setTimeout(_sockjs_onload, 1), "function" == typeof define && define.amd && define("sockjs", [], function() {
    return SockJS;
}), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, App.resident_template = _.template('<div class="well well-sm bottom-space-sm concrete-seller">\n  <div class="media" style="margin: 0; position: relative">\n    <a class="pull-left" href="#">\n      <img class="media-object" src="/new_assets/no_avatar.png" style="width: 48px; height: 48px" ></img>\n    </a>\n    <div class="media-body muted">\n\n      <button class="btn btn-xs btn-default pull-right"  <%= obj.online ? \'\' : \'disabled="disabled"\'  %> rel="tooltip" data-placement="left" title="Разрабатывается">\n        <i class="fa fa-phone"></i>\n        Позвонить\n        <br />\n        <small>\n          <%= obj.phone %>\n        </small>\n      </button>\n\n      <h4 class="bottom-space-xs">\n        <a href="#" id="select-addressee-<%= obj.id %>" class="select-addressee dashed" data-id="<%= obj.id %>"><%= obj.surname %> <%= obj.name %> <%= obj.patronymic %></a>\n      </h4>\n\n      <h6 style="margin: 0; line-height: 12px">\n\n        <%= _.compact([obj.place, obj.post]).join(\'; \') %>\n\n        <% if(obj.online) { %>\n          <span class="label label-success">Онлайн</span>\n        <% } else { %>\n          <span class="label label-default">Оффлайн</span>\n        <% } %>\n\n      </h6>\n\n    </div>\n  </div>\n</div>');
}.call(this), function() {
    var App, Realtime, declOfNum, init;
    App = "undefined" != typeof exports && null !== exports ? exports :this, Realtime = function() {
        function Realtime() {}
        return Realtime.send = function(data) {
            var to_send;
            return console.log("Browser SEND"), to_send = JSON.stringify(data), console.log(to_send), 
            Realtime.sock.send(to_send), console.log("");
        }, Realtime.connect = function() {
            var address, options, protocols;
            return address = "http://" + $("#realtime_address").text() + ":" + $("#realtime_port").text() + "/realtime", 
            protocols = [ "websocket", "xdr-streaming", "xhr-streaming", "iframe-eventsource", "iframe-htmlfile", "xdr-polling", "xhr-polling", "iframe-xhr-polling", "jsonp-polling" ], 
            options = {
                protocols_whitelist:protocols,
                debug:!0,
                devel:!0,
                jsessionid:!1
            }, Realtime.sock = new SockJS(address, void 0, options), Realtime.sock.onopen = function() {
                return console.log("onopen"), Realtime.request_authentication();
            }, Realtime.sock.onmessage = function(e) {
                var $cleared_talk, aa1, aa2, addressee_is_seller, admin_zone, creator_is_seller, data, message, received, visible_talk, _ref, _ref1, _ref2, _ref3, _ref4;
                switch (console.log("Browser RECV"), console.log(e.data), received = JSON.parse(e.data), 
                data = received.data, message = received.message, console.log(""), message) {
                  case "response sellers":
                    return $("#sellers").html(JSON.stringify(data, null, 4)), Realtime.render_sellers();

                  case "response authentication":
                    return $("#authentication").text(data), Realtime.request_sellers(), Realtime.transport();

                  case "show talk":
                    if ($("#user_id").html() === (null != (_ref = data.somebody_id) ? _ref.toString() :void 0) || $("#user_id").html() === (null != (_ref1 = data.creator_id) ? _ref1.toString() :void 0) || $("#user_id").html() === (null != (_ref2 = data.addressee_id) ? _ref2.toString() :void 0) ? (admin_zone = $("#admin_zone").data("value"), 
                    creator_is_seller = _.find(Realtime.get_parsed_sellers(), function(obj) {
                        return obj.id === data.creator_id;
                    }), addressee_is_seller = _.find(Realtime.get_parsed_sellers(), function(obj) {
                        return obj.id === data.addressee_id;
                    }), admin_zone || (null != creator_is_seller && data.creator_id.toString() !== $("#current_user_id").html() ? $("#talk_addressee_id").val(data.creator_id) :null != addressee_is_seller && data.creator_id.toString() === $("#current_user_id").html() && $("#talk_addressee_id").val(data.addressee_id), 
                    data.created_at === data.updated_at && (null != data.addressee_id ? App.select_addressee() :App.unselect_addressee())), 
                    $cleared_talk = $(data.cached_talk), data.created_at !== data.updated_at ? (visible_talk = $('.talk-item[data-id="' + data.id + '"]'), 
                    visible_talk.length > 0 && visible_talk.replaceWith($cleared_talk)) :($("#talk-log").prepend($cleared_talk), 
                    App.Talk.message("<strong>" + data.creator_id + "</strong>", $cleared_talk)), window.bootstrapperize()) :($("#current_user_id").html() === (null != (_ref3 = data.addressee_id) ? _ref3.toString() :void 0) && $(document).trigger("private-message", [ data ]), 
                    null == data.addressee_id && $(document).trigger("broadcast-message", [ data ])), 
                    aa1 = (null != (_ref4 = data.addressee_id) ? _ref4.toString() :void 0) === $("#current_user_id").html(), 
                    aa2 = null == data.addressee_id && data.creator_id.toString() !== $("#current_user_id").html(), 
                    aa1 || aa2) return Realtime.talk_received(data.id);
                }
            }, Realtime.sock.onclose = function() {
                return console.log("onclose"), _.delay(function() {
                    return Realtime.connect();
                }, 5e3);
            };
        }, Realtime;
    }(), App.Realtime = Realtime, Realtime.talk_received = function(id) {
        return $.ajax({
            type:"PATCH",
            url:"/user/talks/" + id,
            data:{
                talk:{
                    received:!0
                }
            },
            dataType:"script"
        });
    }, Realtime.request_sellers = function() {
        var data;
        return data = {
            message:"request sellers"
        }, Realtime.send(data);
    }, Realtime.transport = function() {
        var data;
        return data = {
            message:"transport",
            data:Realtime.sock.protocol
        }, Realtime.send(data);
    }, Realtime.request_authentication = function() {
        var data;
        return data = {
            message:"request authentication",
            data:$.cookie("auth_token")
        }, Realtime.send(data);
    }, declOfNum = function(number, titles) {
        var cases;
        return cases = [ 2, 0, 1, 1, 1, 2 ], titles[number % 100 > 4 && 20 > number % 100 ? 2 :cases[5 > number % 10 ? number % 10 :5]];
    }, Realtime.get_parsed_sellers = function() {
        return JSON.parse($("#sellers").text());
    }, Realtime.render_sellers = function() {
        var online, online_text, sellers;
        return sellers = Realtime.get_parsed_sellers(), online = _.reduce(sellers, function(memo, seller) {
            var _ref;
            return null != (_ref = memo + seller.online) ? _ref :{
                1:0
            };
        }, 0), online_text = online > 1 ? online :"", $("#we-are-online-note").text("На ваш вопрос прямо сейчас " + declOfNum(online, [ "готов", "готовы", "готовы" ]) + " ответить " + online_text + " " + declOfNum(online, [ "менеджер", "менеджера", "менеджеров" ]) + "."), 
        online > 0 ? ($("#talk-details").hide(), $("#talk-details").find("input").prop("disabled", "disabled"), 
        $("#we-are-offline-note").hide(), $("#we-are-online-note").show()) :($("#talk-details").show(), 
        $("#talk-details").find("input").prop("disabled", ""), $("#we-are-offline-note").show(), 
        $("#we-are-online-note").hide()), Realtime.render_sellers_2();
    }, Realtime.render_sellers_2 = function() {
        var addressee_id, seller, sellers, _i, _len, _results;
        for ($("#talk-recipients").html(""), sellers = Realtime.get_parsed_sellers(), addressee_id = $("#talk_addressee_id").val(), 
        _results = [], _i = 0, _len = sellers.length; _len > _i; _i++) seller = sellers[_i], 
        _results.push(addressee_id && seller.id.toString() === addressee_id || !addressee_id ? $("#talk-recipients").append(App.resident_template(seller)) :void 0);
        return _results;
    }, init = function() {
        return Realtime.connect();
    }, $(document).on("page:load", function() {
        return Realtime.request_sellers();
    }), $(document).on("page:update", function() {}), $(function() {
        return init();
    });
}.call(this), function() {
    var App, Talk;
    App = "undefined" != typeof exports && null !== exports ? exports :this, Talk = function() {
        function Talk() {}
        return Talk.visible = !1, Talk.show = function() {
            return this.visible = !0, App.NotifyWindow.hide();
        }, Talk.hide = function() {
            return this.visible = !1, NotifySound.stop();
        }, Talk.message = function(title, text) {
            return title = "<strong>" + $(text).find(".talk-addresser").html() + "</strong>", 
            text = $(text).find(".talk-body").html(), this.visible || NotifyWindow.show(title, text), 
            NotifySound.play();
        }, Talk;
    }(), App.Talk = Talk, $(document).on("show.bs.modal", "#myModal", function() {
        return App.Talk.show();
    }), $(document).on("hidden.bs.modal", "#myModal", function() {
        return App.Talk.hide();
    }), $(document).on("click", "a[rel='ask-question']", function(event) {
        return event.preventDefault(), App.Talk.show(), CKEDITOR.instances.talk_talkable_attributes_content.insertHtml("<p>" + $(this).data("topic") + "</p><p></p>");
    });
}.call(this), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, App.select_addressee = function() {
        return $("#i-want-to-choose-seller-block").hide(), $("#i-dont-want-to-choose-seller-block").show(), 
        Realtime.render_sellers_2(), $("#talk-recipients").show();
    }, App.unselect_addressee = function() {
        return $("#talk_addressee_id").val(""), $("#talk-recipients").hide(), $("#i-want-to-choose-seller-block").show(), 
        $("#i-dont-want-to-choose-seller-block").hide();
    }, $(document).on("click", "#i-want-to-choose-seller", function(e) {
        return e.preventDefault(), App.select_addressee();
    }), $(document).on("click", "#i-dont-want-to-choose-seller", function(e) {
        return e.preventDefault(), App.unselect_addressee();
    }), $(document).on("click", ".select-addressee", function(e) {
        return e.preventDefault(), $("#talk_addressee_id").val($(this).data("id")), Realtime.render_sellers_2();
    });
}.call(this), function() {
    var App;
    App = "undefined" != typeof exports && null !== exports ? exports :this, $(document).on("change", ".talk_read", function() {
        return $(this).closest("form").trigger("submit.rails");
    }), $(document).on("cocoon:after-insert", "#new_talk", function() {
        return App.init_jquery_file_upload();
    });
}.call(this), function() {
    $(document).on("private-message", function(event, data) {
        return $("body").css("background", "red"), $("#private-message").html(JSON.stringify(data, null, 4));
    }), $(document).on("broadcast-message", function(event, data) {
        return $("body").css("background", "blue"), $("#broadcast-message").html(JSON.stringify(data, null, 4));
    });
}.call(this), function() {
    var App, NotifySound;
    App = "undefined" != typeof exports && null !== exports ? exports :this, NotifySound = function() {
        function NotifySound() {}
        return NotifySound._canplaythrough = !1, NotifySound._audio = void 0, NotifySound._is_playing = !1, 
        NotifySound._playing_count = 0, NotifySound._increase_playing_count = function() {
            return NotifySound._playing_count++, this._update_increase_playing_count();
        }, NotifySound._update_increase_playing_count = function() {
            return $("#playing-count").text(NotifySound._playing_count);
        }, NotifySound._change_playing_status = function(status) {
            return NotifySound._is_playing = status, this._update_playing_status();
        }, NotifySound._update_playing_status = function() {
            return $("#is-playing").text(NotifySound._is_playing);
        }, NotifySound._set_canplaythrough = function() {
            return NotifySound._canplaythrough = !0, $("#can-play-through").text(NotifySound._canplaythrough);
        }, NotifySound._init = function() {
            return this._audio = $("#notify-audio"), this._audio.on("canplaythrough", function() {
                return NotifySound._set_canplaythrough();
            }), this._audio.on("playing", function() {
                return NotifySound._increase_playing_count(), NotifySound._change_playing_status(!0);
            }), this._audio.on("pause", function() {
                return NotifySound._change_playing_status(!1);
            }), this._update_increase_playing_count(), this._update_playing_status();
        }, NotifySound.play = function() {
            return NotifySound._canplaythrough && $("#play-sound-on-new-message").data("value") ? (this._audio[0].pause(), 
            this._audio[0].currentTime = 0, this._audio[0].play()) :void 0;
        }, NotifySound.stop = function() {
            return NotifySound._canplaythrough ? this._audio[0].pause() :void 0;
        }, NotifySound;
    }(), $(function() {
        return NotifySound._init();
    }), $(document).on("page:load", function() {
        return NotifySound._init();
    }), App.NotifySound = NotifySound;
}.call(this), function() {
    var App, NotifyWindow;
    App = "undefined" != typeof exports && null !== exports ? exports :this, NotifyWindow = function() {
        function NotifyWindow() {}
        return NotifyWindow._visible = !1, NotifyWindow.visible = function() {
            return this._visible;
        }, NotifyWindow.show = function(title, text) {
            return this._visible = !0, $("#talk-notify").popover("destroy"), $("#talk-notify").attr("data-content", text), 
            $("#talk-notify").attr("data-original-title", this.close_button_template + $("#sound-standard").html() + title), 
            $("#talk-notify").popover("show");
        }, NotifyWindow.hide = function() {
            return this._visible = !1, NotifySound.stop(), $("#talk-notify").popover("hide");
        }, NotifyWindow.close_button_template = '<button id="hide-notify" aria-hidden="true" class="control" data-dismiss="modal" type="button"> <i class="fa fa-times fa-lg"></i> </button>', 
        NotifyWindow;
    }(), App.NotifyWindow = NotifyWindow, $(document).on("click", "#hide-notify", function() {
        return App.NotifyWindow.hide(), !1;
    });
}.call(this), function() {
    var App, NotifySoundToggler;
    App = "undefined" != typeof exports && null !== exports ? exports :this, NotifySoundToggler = function() {
        function NotifySoundToggler() {}
        return NotifySoundToggler.get_status = function() {
            return $("#play-sound-on-new-message").data("value");
        }, NotifySoundToggler.update_icon = function() {
            var icon, status;
            return icon = $(".notify-sound-toggler-icon"), status = this.get_status(), status ? (icon.removeClass("fa fa-volume-off"), 
            icon.addClass("fa fa-volume-up")) :(icon.removeClass("fa fa-volume-up"), icon.addClass("fa fa-volume-off"));
        }, NotifySoundToggler.init = function() {
            var audio, play, stop;
            return audio = $("#notify-toggle-audio").get(0), play = function() {
                try {
                    return audio.pause(), audio.currentTime = 0, audio.play();
                } catch (_error) {}
            }, stop = function() {
                try {
                    return audio.pause();
                } catch (_error) {}
            }, $(document).on("ajax:complete", ".notify-sound-toggler-form", function() {
                return function() {
                    return $("#sound-toggled").data("value", "true"), $("#sound-toggled").text("true");
                };
            }(this)), $(document).on("click", ".notify-sound-toggler-link", function(_this) {
                return function() {
                    var new_status, old_status;
                    return old_status = _this.get_status(), new_status = !old_status, $("#play-sound-on-new-message").data("value", new_status), 
                    $("#play-sound-on-new-message").text(new_status), $(".notify-sound-toggler-checkbox").prop("checked", new_status), 
                    stop(), new_status ? play() :NotifySound.stop(), _this.debounced_submit(), _this.update_icon(), 
                    !1;
                };
            }(this));
        }, NotifySoundToggler.debounced_submit = _.debounce(function() {
            return $(".notify-sound-toggler-form").trigger("submit.rails");
        }, 500), NotifySoundToggler;
    }(), $(document).on("page:update", function() {
        return NotifySoundToggler.update_icon();
    }), $(function() {
        return NotifySoundToggler.init(), NotifySoundToggler.update_icon();
    });
}.call(this), function() {
    $(document).on("page:update", function() {
        return $("#slide-top").affix({
            offset:{
                top:100
            }
        });
    }), $(document).on("click", "#slide-top", function(event) {
        return event.preventDefault(), $("html, body").animate({
            scrollTop:0
        }, "fast");
    });
}.call(this), function() {
    $(document).on("custom-change", '[name="payment[payment_type]"]', function() {
        var block, _i, _len, _ref, _results;
        if ($(this).prop("checked")) {
            for ($(".payment-block").hide(), _ref = $(this).data().blocks, _results = [], _i = 0, 
            _len = _ref.length; _len > _i; _i++) block = _ref[_i], $("#" + block).show(), _results.push($("#" + block).find("[rel~='radio-new-old-switcher']:input").trigger("custom-change"));
            return _results;
        }
    }), $(document).on("custom-change", '[rel~="select-and-fill"]', function() {
        var type_store;
        return type_store = $(this).closest('[rel~="type-store"]'), type_store.find(".select-and-fill").hide(), 
        type_store.find(".select-and-fill").find(":input").prop("disabled", !0), type_store.find("#select-and-fill-" + $(this).val()).show(), 
        type_store.find("#select-and-fill-" + $(this).val()).find(":input").prop("disabled", !1);
    }), $(document).on("change", '[name~="payment[payment_type]"]', function() {
        return $("html, body").animate({
            scrollTop:$("#payment-details").offset().top
        }, "fast");
    });
}.call(this), function() {
    $(document).on("page:update", function() {
        return $("#clientMap").length > 0 ? ($("#clientMap").css("height", 400), $("#clientMapOuter").affix({
            offset:{
                top:function() {
                    return this.top = 121;
                },
                bottom:function() {
                    return this.bottom = $(document).height() - $("#level").offset().top + 20;
                }
            }
        })) :void 0;
    });
}.call(this), function() {}.call(this), function() {
    $(document).on("click", "#assa-link", function(event) {
        return event.preventDefault(), $("#assa-block").show(), $("#assa-result").hide();
    });
}.call(this), function() {
    var format_result, format_selection;
    format_result = function(data) {
        return null != data["new"] ? "Создать: " + data.text.toString().toUpperCase() :data.text;
    }, format_selection = function(data) {
        return data.text.toString().toUpperCase();
    }, $(document).on("page:change", function() {
        return $("[rel='select2-spare-catalog']").select2({
            allowClear:!0,
            initSelection:function(element, callback) {
                var data;
                return data = {
                    id:$(element).val(),
                    true_id:$(element).data("true-id"),
                    text:$(element).val()
                }, callback(data);
            },
            formatResult:format_result,
            formatSelection:format_selection,
            query:function(options) {
                var params, zzz;
                return params = {
                    page:options.page,
                    name:options.term
                }, zzz = void 0, zzz = {
                    results:[]
                }, null == options.context && options.page <= 1 && null != options.term && options.term.length > 0 && zzz.results.push({
                    id:options.term,
                    text:options.term,
                    "new":!0
                }), $.getJSON("/admin/spare_catalogs/search/?" + $.param(params), function(data) {
                    return data.map(function(data) {
                        return zzz.results.push({
                            id:data.name,
                            true_id:data.id,
                            text:data.name
                        });
                    }), data.length && (zzz.more = !0), options.callback(zzz);
                });
            }
        });
    });
}.call(this);