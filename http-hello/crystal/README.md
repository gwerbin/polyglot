* [x] Respond to HTTP GET `/` with:
  * [x] Sleep for 0.25 seconds.
  * [x] Status code `200` and reason `OK`.
  * [x] Body containing the JSON data `{"time": "<datetime>", "datum": ["eAcute is é, combinedEAcute is é; precomposed is 한, decomposed is 한", 1, null, [0, 0.0]]}` (example taken from [the Swift book](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html))
    * [x] The `<datetime>` should be RFC 3339 format: `YYYY-MM-DD HH:MM:SS ±HH:MM` (like ISO 8601 but with spaces and no `"T"`).
  * [x] Provide the response header `Content-Type: application/json; charset=utf-8`.
  * [x] Provide the response header `Content-Length: 144`.
    * [x] Do not hard-code the response header; calculate it.
  * [ ] Respect the `Accept-Encoding` provided by the client that has the highest quality value, with support for:
    * [ ] ★ `gzip` (LZ77)
    * [ ] ★ `compress` (LZW)
    * [ ] ★ `deflate` (zlib)
    * [ ] ★ `br` (brotli)
* [ ] Respond to requests for all other paths with HTTP 404 `Not found`, with no body.
* [ ] Respond to requests in all other methods with HTTP 405 `Method not allowed`, with no body.
* [ ] Respond to requests with `Accept-Charset` of anything other than UTF-8 with HTTP 406 `Not acceptable`; if omitted, assume UTF-8.
* [x] Environment variables (superseded by CLI options):
  * [x] `HELLO_DELAY` modifies sleep time.
* [x] Command line options:
  * [x] `--delay` modifies sleep time.
* [x] Command line arguments:
  * [x] _required_ HTTP port to listen on (e.g. 8080).
* [x] Sleep time validation: inclusive minimum 0.0 and inclusive maximum 5.0 (emit some kind of error if out of bounds, and return status 1)
* [x] Emit some kind of error and return status 1 if command line is invalid.
* [ ] Performance:
  * [ ] ★ Handle 100 concurrent requests in no greater than `sleep_time * 100 + 10` seconds
  * [ ] ★★ Handle 100 concurrent requests in no greater than `sleep_time * 100 + 5` seconds
  * [ ] ★★★ Handle 100 concurrent requests in no greater than `sleep_time * 100 + 1` seconds
* [ ] Deliver some kind of "importable" library, not just a "script".
