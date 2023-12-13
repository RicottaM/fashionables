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
 <div class="panel panel-sync" v-show="currentPage === 'sync'">
    <h3 class="panel-heading">
        <span class="panel-heading-icon-container">
            <i class="las la-save la-2x"></i>
            {l s='Store sync' mod='mailchimppro'}
        </span>
        <div class="panel-heading-action">
            <button id="desc-attribute_group-new"
                    v-on:click="saveSettings"
                    v-if="validApiKey"
                    title="{l s='Save settings' mod='mailchimppro'}"
                    class="list-toolbar-btn btn btn-success">
                <i class="las la-save la-2x"></i>
                <span>{l s='Save' mod='mailchimppro'}</span>
            </button>
        </div>
    </h3>
    <div class="panel-body">

        <div class="form-group">
            <h2>{l s='Choose Mailchimp list' mod='mailchimppro'}</h2>
            <div class="clearfix"></div>
            <div class="listid-select-container">
                {literal}
                    <Multiselect
                        placeholder="{/literal}{l s='Please select audience list for the current prestashop store' mod='mailchimppro'}{literal}"
                        v-model="listId"
                        :can-deselect="false"
                        :can-clear="false"
                        :mode="'single'"
                        :options="lists"
                        :disabled="(storeSynced == true || storeAlreadySynced == true) ? true : false"
                    >
                    </Multiselect>
                {/literal}
                <button v-cloak v-if="storeSynced == false" type="button" :class="listId ? 'btn btn-primary' : 'btn btn-primary disabled'" v-on:click="syncStore">
                    {l s='Sync store' mod='mailchimppro'}
                </button>
            </div>
            <div class="clearfix"></div>
            {if isset($storeSyncNoteMessage)}
                <p class="text-muted">
                    {$storeSyncNoteMessage nofilter} {* HTML comment, no escape necessary *}
                </p>
            {/if}
            <br>
            {if isset($storeSyncWarningMessage)}
                <div v-cloak v-if="storeSynced == false" class="alert alert-warning">
                    <div>{$storeSyncWarningMessage nofilter}</div> {* HTML comment, no escape necessary *}
                </div>
            {/if}
            <div v-cloak v-if="listId && storeSynced == false" class="alert alert-info">
                {if isset($storeSyncInfoMessage)}
                    <p>{$storeSyncInfoMessage}</p>
                {/if}
                <p>{l s='Please click on the Sync store button.' mod='mailchimppro'}</p>
                {* <p v-if="listId && storeSynced == false">{l s='Please click on the Sync store button to proceed the store synchronization.' mod='mailchimppro'}</p> *}
            </div>
        </div>

        <hr>
        
        <div :class="storeSynced == true ? 'sync-settings-container' : 'sync-settings-container no-sync-type'">
            <div class="form-group">
                <h2>{l s='Objects to sync with Mailchimp' mod='mailchimppro'}</h2>
                <ul id="sync-list" class="list-unstyled">
                    <li>
                        <label>
                            <span class="custom-checkbox-container">
                                <input type="checkbox" v-model="syncProducts">
                                <span class="custom-checkbox">
                                    <i class="material-icons icon-done">&#xe876;</i>
                                </span>
                                <span class="custom-checkbox-text">{l s='Sync products' mod='mailchimppro'} <span>{literal}({{numberOfProductsToSync}}){/literal}</span></span>
                            </span>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span class="custom-checkbox-container">
                                <input type="checkbox" v-model="syncCustomers">
                                <span class="custom-checkbox">
                                    <i class="material-icons icon-done">&#xe876;</i>
                                </span>
                                <span class="custom-checkbox-text">{l s='Sync customers' mod='mailchimppro'} <span>{literal}({{numberOfCustomersToSync}}){/literal}</span></span>
                            </span>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span class="custom-checkbox-container">
                                <input type="checkbox" v-model="syncCartRules">
                                <span class="custom-checkbox">
                                    <i class="material-icons icon-done">&#xe876;</i>
                                </span>
                                <span class="custom-checkbox-text">{l s='Sync cart rules' mod='mailchimppro'} <span>{literal}({{numberOfCartRulesToSync}}){/literal}</span></span>
                            </span>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span class="custom-checkbox-container">
                                <input type="checkbox" v-model="syncOrders">
                                <span class="custom-checkbox">
                                    <i class="material-icons icon-done">&#xe876;</i>
                                </span>
                                <span class="custom-checkbox-text">{l s='Sync orders' mod='mailchimppro'} <span>{literal}({{numberOfOrdersToSync}}){/literal}</span></span>
                            </span>
                        </label>
                    </li>
                    <li>
                        <label>
                            <span class="custom-checkbox-container">
                                <input type="checkbox" v-model="syncNewsletterSubscribers">
                                <span class="custom-checkbox">
                                    <i class="material-icons icon-done">&#xe876;</i>
                                </span>
                                <span class="custom-checkbox-text">{l s='Sync newsletter subscribers' mod='mailchimppro'} <span>{literal}({{numberOfNewsletterSubscribersToSync}}){/literal}</span></span>
                            </span>
                        </label>
                    </li>
                </ul>
            </div>
        </div>
		
		<div v-cloak v-if="jobsAddedToQueue" class="alert alert-success">
			<p>
                <strong>{l s='Jobs have been put to the queue; set up the cronjob now!' mod='mailchimppro'}</strong>
            </p>
		</div>
    </div>
    <div v-cloak v-if="storeSynced" class="panel-footer">
        <button type="button" :class="listId ? 'btn btn-primary pull-right' : 'btn btn-primary pull-right disabled'" v-on:click="pushSetupJobsToQueue">
            {l s='Add jobs to queue' mod='mailchimppro'}
        </button>
    </div>
</div>