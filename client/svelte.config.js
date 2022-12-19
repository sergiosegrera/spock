import adapter from '@sveltejs/adapter-auto';

// Enable if you only require a static page
// import adapter from '@sveltejs/adapter-static';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	kit: {
		adapter: adapter()
	}
};

export default config;
