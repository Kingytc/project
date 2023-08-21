/* Author  : shiva
 * Date	   : 12/11/2020
 * Purpose : Encryption
 */

var chrsz   = 8;
var b64pad  = "=";
function callSaltedHash(salt,pwd)
{
    var keyBits = CryptoJS.PBKDF2(pwd, salt, { keySize: 1024/32 });
    var keyBitsIterations = CryptoJS.PBKDF2(pwd, salt, { keySize: 1024/32, iterations: 75 });
    document.forms[0].hidpass.value=keyBitsIterations;
}
function callSalt()
{
    var randSalt = CryptoJS.lib.WordArray.random(256/8);
    document.forms[0].saltHash.value=randSalt;
	return randSalt;
}
function callPbkdf2()
{
	var password=callConversion();
	if((document.forms[0].txtusr_id.value!="")&&(password!=""))
	{
		var saltVal = callSalt();
		callSaltedHash(saltVal,password);
	}
}
function binb2b64(binarray)
{
  var tab = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
  var str = "";
  for(var i = 0; i < binarray.length * 4; i += 3)
  {
    var triplet = (((binarray[i   >> 2] >> 8 * (3 -  i   %4)) & 0xFF) << 16)
                | (((binarray[i+1 >> 2] >> 8 * (3 - (i+1)%4)) & 0xFF) << 8 )
                |  ((binarray[i+2 >> 2] >> 8 * (3 - (i+2)%4)) & 0xFF);
    for(var j = 0; j < 4; j++)
    {
      if(i * 8 + j * 6 > binarray.length * 32) str += b64pad;
      else str += tab.charAt((triplet >> 6*(3-j)) & 0x3F);
    }
  }
 
  return str;
}
function callConversion()
{
	var chrsz   = 8;
	var val=document.forms[0].txtusr_password.value;
	//val = val + val.charAt(0)+ val.charAt(1);
	res=binb2b64(core_sha1(str2binb(val),val.length * chrsz));
	return res;
	
}
/*
 * Convert an 8-bit or 16-bit string to an array of big-endian words
 * In 8-bit function, characters >255 have their hi-byte silently ignored.
 */
function str2binb(str)
{
  var bin = Array();
  var mask = (1 << chrsz) - 1;
  for(var i = 0; i < str.length * chrsz; i += chrsz)
    bin[i>>5] |= (str.charCodeAt(i / chrsz) & mask) << (24 - i%32);
  return bin;
}
/*
 * Calculate the SHA-1 of an array of big-endian words, and a bit length
 */
function core_sha1(x, len)
{
  /* append padding */
  x[len >> 5] |= 0x80 << (24 - len % 32);
  x[((len + 64 >> 9) << 4) + 15] = len;

  var w = Array(80);
  var a =  1732584193;
  var b = -271733879;
  var c = -1732584194;
  var d =  271733878;
  var e = -1009589776;

  for(var i = 0; i < x.length; i += 16)
  {
    var olda = a;
    var oldb = b;
    var oldc = c;
    var oldd = d;
    var olde = e;

    for(var j = 0; j < 80; j++)
    {
      if(j < 16) w[j] = x[i + j];
      else w[j] = rol(w[j-3] ^ w[j-8] ^ w[j-14] ^ w[j-16], 1);
      var t = safe_add(safe_add(rol(a, 5), sha1_ft(j, b, c, d)), 
                       safe_add(safe_add(e, w[j]), sha1_kt(j)));
      e = d;
      d = c;
      c = rol(b, 30);
      b = a;
      a = t;
    }

    a = safe_add(a, olda);
    b = safe_add(b, oldb);
    c = safe_add(c, oldc);
    d = safe_add(d, oldd);
    e = safe_add(e, olde);
  }
  return Array(a, b, c, d, e);
  
}
/*
 * Add integers, wrapping at 2^32. This uses 16-bit operations internally
 * to work around bugs in some JS interpreters.
 */
function safe_add(x, y)
{
  var lsw = (x & 0xFFFF) + (y & 0xFFFF);
  var msw = (x >> 16) + (y >> 16) + (lsw >> 16);
  return (msw << 16) | (lsw & 0xFFFF);
}
/*
 * Perform the appropriate triplet combination function for the current
 * iteration
 */
function sha1_ft(t, b, c, d)
{
  if(t < 20) return (b & c) | ((~b) & d);
  if(t < 40) return b ^ c ^ d;
  if(t < 60) return (b & c) | (b & d) | (c & d);
  return b ^ c ^ d;
}
/*
 * Determine the appropriate additive constant for the current iteration
 */
function sha1_kt(t)
{
  return (t < 20) ?  1518500249 : (t < 40) ?  1859775393 :
         (t < 60) ? -1894007588 : -899497514;
} 
/*
 * Bitwise rotate a 32-bit number to the left.
 */
function rol(num, cnt)
{
  return (num << cnt) | (num >>> (32 - cnt));
}

var CryptoJS=CryptoJS||function(g,i){var f={},b=f.lib={},m=b.Base=function(){function a(){}return{extend:function(e){a.prototype=this;var c=new a;e&&c.mixIn(e);c.$super=this;return c},create:function(){var a=this.extend();a.init.apply(a,arguments);return a},init:function(){},mixIn:function(a){for(var c in a)a.hasOwnProperty(c)&&(this[c]=a[c]);a.hasOwnProperty("toString")&&(this.toString=a.toString)},clone:function(){return this.$super.extend(this)}}}(),l=b.WordArray=m.extend({init:function(a,e){a=
this.words=a||[];this.sigBytes=e!=i?e:4*a.length},toString:function(a){return(a||d).stringify(this)},concat:function(a){var e=this.words,c=a.words,o=this.sigBytes,a=a.sigBytes;this.clamp();if(o%4)for(var b=0;b<a;b++)e[o+b>>>2]|=(c[b>>>2]>>>24-8*(b%4)&255)<<24-8*((o+b)%4);else if(65535<c.length)for(b=0;b<a;b+=4)e[o+b>>>2]=c[b>>>2];else e.push.apply(e,c);this.sigBytes+=a;return this},clamp:function(){var a=this.words,e=this.sigBytes;a[e>>>2]&=4294967295<<32-8*(e%4);a.length=g.ceil(e/4)},clone:function(){var a=
m.clone.call(this);a.words=this.words.slice(0);return a},random:function(a){for(var e=[],c=0;c<a;c+=4)e.push(4294967296*g.random()|0);return l.create(e,a)}}),n=f.enc={},d=n.Hex={stringify:function(a){for(var e=a.words,a=a.sigBytes,c=[],b=0;b<a;b++){var d=e[b>>>2]>>>24-8*(b%4)&255;c.push((d>>>4).toString(16));c.push((d&15).toString(16))}return c.join("")},parse:function(a){for(var e=a.length,c=[],b=0;b<e;b+=2)c[b>>>3]|=parseInt(a.substr(b,2),16)<<24-4*(b%8);return l.create(c,e/2)}},j=n.Latin1={stringify:function(a){for(var e=
a.words,a=a.sigBytes,b=[],d=0;d<a;d++)b.push(String.fromCharCode(e[d>>>2]>>>24-8*(d%4)&255));return b.join("")},parse:function(a){for(var b=a.length,c=[],d=0;d<b;d++)c[d>>>2]|=(a.charCodeAt(d)&255)<<24-8*(d%4);return l.create(c,b)}},k=n.Utf8={stringify:function(a){try{return decodeURIComponent(escape(j.stringify(a)))}catch(b){throw Error("Malformed UTF-8 data");}},parse:function(a){return j.parse(unescape(encodeURIComponent(a)))}},h=b.BufferedBlockAlgorithm=m.extend({reset:function(){this._data=l.create();
this._nDataBytes=0},_append:function(a){"string"==typeof a&&(a=k.parse(a));this._data.concat(a);this._nDataBytes+=a.sigBytes},_process:function(a){var b=this._data,c=b.words,d=b.sigBytes,j=this.blockSize,h=d/(4*j),h=a?g.ceil(h):g.max((h|0)-this._minBufferSize,0),a=h*j,d=g.min(4*a,d);if(a){for(var f=0;f<a;f+=j)this._doProcessBlock(c,f);f=c.splice(0,a);b.sigBytes-=d}return l.create(f,d)},clone:function(){var a=m.clone.call(this);a._data=this._data.clone();return a},_minBufferSize:0});b.Hasher=h.extend({init:function(){this.reset()},
reset:function(){h.reset.call(this);this._doReset()},update:function(a){this._append(a);this._process();return this},finalize:function(a){a&&this._append(a);this._doFinalize();return this._hash},clone:function(){var a=h.clone.call(this);a._hash=this._hash.clone();return a},blockSize:16,_createHelper:function(a){return function(b,c){return a.create(c).finalize(b)}},_createHmacHelper:function(a){return function(b,c){return u.HMAC.create(a,c).finalize(b)}}});var u=f.algo={};return f}(Math);
(function(){var g=CryptoJS,i=g.lib,f=i.WordArray,i=i.Hasher,b=[],m=g.algo.SHA1=i.extend({_doReset:function(){this._hash=f.create([1732584193,4023233417,2562383102,271733878,3285377520])},_doProcessBlock:function(f,n){for(var d=this._hash.words,j=d[0],k=d[1],h=d[2],g=d[3],a=d[4],e=0;80>e;e++){if(16>e)b[e]=f[n+e]|0;else{var c=b[e-3]^b[e-8]^b[e-14]^b[e-16];b[e]=c<<1|c>>>31}c=(j<<5|j>>>27)+a+b[e];c=20>e?c+((k&h|~k&g)+1518500249):40>e?c+((k^h^g)+1859775393):60>e?c+((k&h|k&g|h&g)-1894007588):c+((k^h^g)-
899497514);a=g;g=h;h=k<<30|k>>>2;k=j;j=c}d[0]=d[0]+j|0;d[1]=d[1]+k|0;d[2]=d[2]+h|0;d[3]=d[3]+g|0;d[4]=d[4]+a|0},_doFinalize:function(){var b=this._data,f=b.words,d=8*this._nDataBytes,j=8*b.sigBytes;f[j>>>5]|=128<<24-j%32;f[(j+64>>>9<<4)+15]=d;b.sigBytes=4*f.length;this._process()}});g.SHA1=i._createHelper(m);g.HmacSHA1=i._createHmacHelper(m)})();
(function(){var g=CryptoJS,i=g.enc.Utf8;g.algo.HMAC=g.lib.Base.extend({init:function(f,b){f=this._hasher=f.create();"string"==typeof b&&(b=i.parse(b));var g=f.blockSize,l=4*g;b.sigBytes>l&&(b=f.finalize(b));for(var n=this._oKey=b.clone(),d=this._iKey=b.clone(),j=n.words,k=d.words,h=0;h<g;h++)j[h]^=1549556828,k[h]^=909522486;n.sigBytes=d.sigBytes=l;this.reset()},reset:function(){var f=this._hasher;f.reset();f.update(this._iKey)},update:function(f){this._hasher.update(f);return this},finalize:function(f){var b=
this._hasher,f=b.finalize(f);b.reset();return b.finalize(this._oKey.clone().concat(f))}})})();
(function(){var g=CryptoJS,i=g.lib,f=i.Base,b=i.WordArray,i=g.algo,m=i.HMAC,l=i.PBKDF2=f.extend({cfg:f.extend({keySize:4,hasher:i.SHA1,iterations:1}),init:function(b){this.cfg=this.cfg.extend(b)},compute:function(f,d){for(var g=this.cfg,k=m.create(g.hasher,f),h=b.create(),i=b.create([1]),a=h.words,e=i.words,c=g.keySize,g=g.iterations;a.length<c;){var l=k.update(d).finalize(i);k.reset();for(var q=l.words,t=q.length,r=l,s=1;s<g;s++){r=k.finalize(r);k.reset();for(var v=r.words,p=0;p<t;p++)q[p]^=v[p]}h.concat(l);
e[0]++}h.sigBytes=4*c;return h}});g.PBKDF2=function(b,d,f){return l.create(f).compute(b,d)}})();