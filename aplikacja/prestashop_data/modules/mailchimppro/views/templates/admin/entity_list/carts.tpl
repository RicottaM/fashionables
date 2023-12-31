{*
 * PrestaChamps
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Commercial License
 * you can't distribute, modify or sell this code
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file
 * If you need help please contact leo@prestachamps.com
 *
 * @author    Mailchimp
 * @copyright Mailchimp
 * @license   commercial
 *}
<div class="table-responsive">
    <table class="table table-bordered">
        <thead>
        <tr>
            <th>{l s='ID' mod='mailchimppro'}</th>
            <th>{l s='Customer' mod='mailchimppro'}</th>
            <th>{l s='Order total' mod='mailchimppro'}</th>
            <th>{l s='Products' mod='mailchimppro'}</th>
            <th>{l s='Created at' mod='mailchimppro'}</th>
            <th>{l s='Updated at' mod='mailchimppro'}</th>
            <th>{l s='Actions' mod='mailchimppro'}</th>
        </tr>
        </thead>
        <tbody>
        {foreach $carts as $cart}
            <tr>
                <td>{$cart.id|escape:'htmlall':'UTF-8'}</td>
                <td>{$cart.customer.email_address|escape:'htmlall':'UTF-8'}</td>
                <td>{$cart.order_total|escape:'htmlall':'UTF-8'} {$cart.currency_code|escape:'htmlall':'UTF-8'}</td>
                <td>
                    {include file='./cart/line.tpl' lines=$cart.lines currency_code=$cart.currency_code}
                </td>
                <td>{$cart.created_at|escape:'htmlall':'UTF-8'}</td>
                <td>{$cart.updated_at|escape:'htmlall':'UTF-8'}</td>
                <td>
					<div class="btn-group btn-group-xs">
						<a class="btn btn-default" href="{LinkHelper::getAdminLink('AdminMailchimpProCarts', true, [], ['action' => 'entitydelete', 'entity_id' => $cart.id])|escape:'htmlall':'UTF-8'}" title="{l s='Delete' mod='mailchimppro'}">
							<i class="icon icon-trash" aria-hidden="true"></i>
							<span>{l s='Delete' mod='mailchimppro'}</span>
						</a>
					</div>
                </td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>