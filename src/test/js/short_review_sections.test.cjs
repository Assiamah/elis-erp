const {test} = require('node:test');
const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

function page() {
    const events = [], requests = [], opens = [];
    const status = {textContent: '', classList: {add() {}, remove() {}}, setAttribute() {}};
    const field = {dataset: {shortHydrate: 'field', shortControl: 'true'}, value: 'old',
        parentElement: {closest() { return null; }}};
    const replacement = {value: 'fresh'};
    const modal = {hasAttribute() {return true;}, setAttribute() {}, querySelectorAll() {return [field];}};
    const fresh = {hasAttribute() {return true;}, querySelector() {return replacement;}};
    let validResponse = true;
    const button = {disabled: false, innerHTML: 'Details', dataset: {},
        parentElement: {querySelector() {return status;}},
        getAttribute() {return '#step';}, closest() {return button;},
        click() {
            const event = {target: button, prevented: false,
                preventDefault() {this.prevented = true;}, stopImmediatePropagation() {}};
            events.find(e => e.type === 'click' && e.capture).handler(event);
            if (!event.prevented) opens.push(field.value);
            return event;
        }};
    const document = {addEventListener(type, handler, capture) {events.push({type, handler, capture});},
        getElementById(id) {return id === 'short-review-context' ? {value: 'page-token'} : id === 'step' ? modal : null;}};
    vm.runInNewContext(fs.readFileSync('src/main/resources/static/js-pages/short_review_sections.js', 'utf8'), {
        document, WeakSet, Array,
        DOMParser: class {parseFromString() {return {getElementById() {return validResponse ? fresh : null;}};}},
        $: {ajax(options) {
            const callbacks = {};
            const chain = {done(f) {callbacks.done = f; return chain;}, fail(f) {callbacks.fail = f; return chain;},
                always(f) {callbacks.always = f; return chain;}};
            requests.push({options, resolve() {callbacks.done('<div>fixture</div>'); callbacks.always();},
                reject(status) {callbacks.fail({status}); callbacks.always();}});
            return chain;
        }}
    });
    events.find(e => e.type === 'DOMContentLoaded').handler();
    return {button, field, requests, opens, status, invalidate() {validResponse = false;}};
}

test('no eager request; hydrates existing controls before opening, and refreshes on reopen', () => {
    const p = page(), field = p.field;
    assert.equal(p.requests.length, 0);
    assert.equal(p.button.click().prevented, true);
    assert.equal(p.button.disabled, true);
    assert.equal(p.opens.length, 0);
    assert.equal(p.requests[0].options.url, 'short_review_modal');
    assert.equal(p.requests[0].options.data.context, 'page-token');
    assert.equal(p.requests[0].options.data.modal, 'step');
    p.requests[0].resolve();
    assert.equal(p.field, field);
    assert.deepEqual(p.opens, ['fresh']);
    assert.equal(p.button.disabled, false);
    p.button.click();
    assert.equal(p.requests.length, 2);
});

test('failed and malformed responses keep details closed and permit retry', () => {
    for (const failure of [401, 410, 502, 'malformed']) {
        const p = page();
        p.button.click();
        if (failure === 'malformed') {p.invalidate(); p.requests[0].resolve();}
        else p.requests[0].reject(failure);
        assert.equal(p.opens.length, 0);
        assert.equal(p.field.value, 'old');
        assert.equal(p.button.disabled, false);
        assert.ok(p.status.textContent.length);
        p.button.click();
        assert.equal(p.requests.length, 2);
    }
});
