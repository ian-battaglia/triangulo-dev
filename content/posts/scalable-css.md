---
title: "Building scalable CSS"
date: 2019-02-27T19:57:29-03:00
draft: true
---

CSS has 374 standardized properties, of which 360 are supported in its current CSS3 version. There isn’t just single way of achieving similar layouts and similar looking pages. Choosing what to use to build user interfaces is completely up to us, developers. However, there are a few ways to ensure that our components are styled in a flexible manner, ready to take on future design changes.

## Give up positioning control

We can position basically anything anywhere using CSS. It is a common practice to avoid having too many elements with position: fixed or position: absolute around a page, in order to let the browser layout engines properly render things where they should go. Giving up positioning control on the component level goes even deeper than that.

When we try to control the position of an element, that element becomes less reusable in different contexts and might need more refactoring when a redesign comes. Let me explain.

Say we have an image gallery listing a few Figure components (by component I mean some HTML, CSS, and JS that works together). Figure has a title, an image, and a caption. When building this component it is easy to think about the context it is displayed in and try to control positioning from within the component.

{image}

Let’s say every Figure needs to be equally spaced in the gallery in one row.  If we try to control the spacing and positioning of the Figure element from within the component CSS, we might start by using display: inline-block and adding a 10px margin to every Figure.  This will work fine for the gallery page. 

One day, we receive a design mockup that uses the same Figure component, but on a completely different page – this time, the Figure needs to appear in two rows, with varying margins.  Since we control the positioning within the Figure component CSS, pages with different layouts won’t be able to use it as is and we might have to add an alternative class to override positioning styles depending on the page it is used. To avoid this issue, we should give up positioning control, at least at such standalone and shared component as Figure.

A better way would be to let the gallery page style itself and position its children as it wishes, since it is the component that is most aware of the visual relationship between multiple elements. Such positioning can be achieved by making use of display: grid and related rules to set columns, rows, gaps, and alignment – or Flexbox, floats, and other CSS layouting techniques.

{image}

When the parent has control of the positioning of its children, and the children know how to adapt itself to its parent, components are more easily reusable inside different contexts.

## Give up sizing control

Similar to positioning, it is also very useful to give up sizing control. On the gallery page we just implemented, we could have styled Figure so that it has a fixed width of 300px because that was the exact width of the element in the design mockup. If we later decide to use Figure in a container that is narrower, we would have an issue.

However, had we given up sizing control and used width: 100% any container wrapping Figure would be able to control its size as needed.

{image}

There are a few use cases where it is not possible to give up sizing control. Some components might need to adapt their size or positioning depending on the space they have available to be displayed. The lack of Container Queries in CSS makes it even harder to implement completely standalone components that can be sized and positioned by their parents. It is important to always keep the tradeoffs in mind though and take control only when not possible to give it up.

## Mind the content

When building components that display dynamic content, planning for different sizes and shapes of content can help. Buttons might have more content than fits in a single line. Images might not always be a square. Titles might have big words that don’t fit one single line. Content is dynamic and so should our component.

There are two general ways of dealing with content variety: forcing content to conform to our component (controlled approach) and letting the component adapt to the content (fluid approach).

{image}

To force content to conform to a component, we could use overflow: hidden rules, fixed widths and heights, text-overflow: ellipsis and many other rules. The controlled approach might be necessary to keep visual balance or prevent bad content from breaking the user interface. The downside is that content requirements might change in the future, forcing us to refactor every component that doesn’t display the new content in an optimal way.

When we code a component that adjusts itself to its content, future content changes will get applied without the need to refactor components, and the whole user interface will be flexible to fit the new content. CSS default values are usually the ones that provide the most flexibility for our content. New layout techniques like Flexbox and CSS Grid also have defaults that allow the content to control sizing and positioning. It might be frightening to not have full control of how a component and a full page will look like in the end. By using some declarations like overflow-wrap: break-word and min-width: 200px we can control the limits of how our component will behave, while still being flexible enough.

## Key takeaways

- The component that is most aware of the relationship between elements in layout should be the one handling positioning and sizing.  If a component is not aware of adjacent components, it should give up its positioning and sizing control. 

- Use layout methods like flexbox or grid layout to control alignment and spacing, instead of using a combination of display values and margins. 

- Let components adapt to dynamic content, instead of forcing content to conform to the size of the component. 

Special thanks to Sua Yoo, for reviewing the drafts of this content.