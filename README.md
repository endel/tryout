Tryout [![Build Status](https://secure.travis-ci.org/endel/tryout.png)](http://travis-ci.org/endel/tryout)
===

Allows you to do dirty stuff without messing up your code base.

Background
---

I've found myself using begin/rescue/retry through HTTP requests frequently, due
timeout, weird stuff caused by a messed up third-party service, or even due
internet connectivity lost.


How to use
---

Currently, Tryout supports 3 alternatives of conditional logic.

**if**

    value = Tryout.try { RestClient.get('http://www.google.com') }.retry(3, :if => :empty?)

**unless**

    value = Tryout.try { RestClient.get('http://www.google.com') }.retry(3, :unless => :present?)

**custom block**

    value = Tryout.try { RestClient.get('http://www.google.com') }.retry(3) do |invalid|
      # Invalidate when response have length lesser than 100
      invalid.length < 100
    end

License
---

Tryout is released under the MIT license. Please read the LICENSE file.